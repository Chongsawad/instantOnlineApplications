class SitesController < ApplicationController
  # GET /sites
  # GET /sites.xml
  before_filter :authenticate_user!
  
  def index
    @sites = current_user.sites

    respond_to do |format|
      format.html
      format.json { render :json => @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.xml
  def show
    @site = Site.find(params[:id])
    @user = @site.user
    @project = @site.project

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /sites/new
  # GET /sites/new.xml
  def new

    @project = Project.find(params[:project_id])
    @site = @project.sites.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
  end

  # POST /sites
  # POST /sites.xml
  def create
    
    @site = Site.new(params[:site])
    @site.user = current_user
    # site_path is the destination path which store all of resource of this site
    # site_path should be the same as the path in capistrano file(cap file)
    @site.path = "/var/www/users/#{@site.user.id}/#{@site.user.id}_#{@site.name}"
    @site.status = "Promt for Install"
    
    
    respond_to do |format|
      
      if Site.find_by_name(@site.name) != nil
          flash[:error] = 'Site name is exist.'
          format.html { redirect_to(@site) }
      else
        if @site.validate_site_name(@site.name)
          if @site.save
            
            #New Deployment Ticket
            @deploy = @site.build_deployment
            @deploy.name = "Deployment"
            
            #Add a automated script
            @deploy.recipe = @site.project.recipe
            @deploy.save
            
            #Add parameters to Config Param Table
            @site.deployment.configParameters.create(:name => "application", :value => @site.name)
            @site.deployment.configParameters.create(:name => "user", :value => @site.user.username)
            @site.deployment.configParameters.create(:name => "deploy_to", :value => "/var/www/users/#{@site.user.id}/#{@site.user.id}_#{@site.name}")
            
            @site.save
            format.html { redirect_to @site }
            format.xml  { render :xml => @site, :status => :created, :location => @site }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
          end
        else
          flash[:warning] = 'Site name is incorrect'
          format.html { render :action => "new"}
          format.xml  { render :xml => @site.errors, :status => :'Site name is incorrect' }
        end
      end
    end
  end
  
  def deploy
    
    @site = Site.find(params[:id])
    @project = Project.find(@site.project_id)
    @site.user = current_user
    @site.status = "Deploying Process"
    
    if @site.save
      
      render :layout => "action", :template => "/sites/deploy"
      
      @site.deploy_on_background(@site)
      
    else
      render :action => "index"
      
    end
  end
  
  def re_deploy
    @site = Site.find(params[:id])

    if @site.path
      @site.status = "Re-deploying!"
      if @site.save
       render :layout => "action", :template => "/sites/re_deploy"
       @site.deploy_on_background(@site)
      else 
        redirect_to(@site, :notice => "ERROR FILE PATH. Please contact administrator.")
      end

    else
      redirect_to(@site, :notice => "Database Error. Please contact administrator.")

    end
  end
  
  # PUT /sites/1
  # PUT /sites/1.xml
  def update
    @site = Site.find(params[:id])
    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to(@site, :notice => 'Site was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # CLEAN /sites/:id/clean
  def clean_database
    @site = Site.find(params[:id])
    render :layout => "action", :template => "/sites/clean_database"
    @site.status = "Cleaning database"
    if @site.save
      @site.clean_database(@site)
    else
      redirect_to(@site, :notice => "Database Error. Please contact administrator.")
    end
  end
  
  def uninstall
    @site = Site.find(params[:id])
    @site.status = "Uninstall Application"
    
    if @site.save
      render :layout => "action", :template => "sites/uninstall"
      @site.uninstalling_on_fire(@site)

    else
      redirect_to(@site, :warning => "Uninstall site incomplete!. Please contact administrator.")
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.xml
  def destroy
    @site = Site.find(params[:id])
    
    if @site.uninstall(@site) == true 
      puts "\n\n\n----------- DESTROYED -----------\n\n\n"
      puts "SITE = #{@site.name}"
      @site.destroy
      @site.save
      
      respond_to do |format|
        format.html { redirect_to(sites_url, :notice => "Your site was successfully deleted.") }
        format.xml  { head :ok }
      end
    else
      redirect_to(@site, :warning => "Remove site incomplete!. Please contact administrator.")
    end
  end

  def reload
    @site = Site.find(params[:id])
    @site.status = "Reload Server"
    if @site.reload_service
      @site.status = "Online"
      @site.save
      redirect_to(@site, :notice => "Site was successfully reload.")
    end
  end
  
  def get_log
    @site = Site.find(params[:id])
    if File.exist?("log/production.log")
      respond_to do |format|
        format.text { send_file "log/production.log", :type => 'text/html'}
      end
    else
      flash[:warning] = "Cannot Access log file. You have to install the application before view a log file"
      redirect_to(@site)
    end
  end
end
