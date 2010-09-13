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
    
    @project = Project.find(@site.project_id)
    # site_path is the destination path which store all of resource of this site
    # site_path should be the same as the path in capistrano file(cap file)
    # @site.path = "/home/inice/InstantSOA/deploy_cap/inice/#{current_user.id}_#{params[:site][:name]}"
    
    @site.path = "/home/inice/users/#{current_user.id}/#{current_user.id}_#{params[:site][:name]}"
    @site.status = "Promt for Install"
    @site.user = current_user
    
    respond_to do |format|
      
      if Site.find_by_name(@site.name) != nil
          format.html { redirect_to(@site, :error => 'Cannot create site with name.') }
      else    
        if @site.save
          #Delayed::Job.enqueue(DeployingJob.new(current_user, @project, @site))

          format.html { redirect_to @site }
          format.xml  { render :xml => @site, :status => :created, :location => @site }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
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
      
      render :template => "/sites/deploy"
      
      @site.deploy_on_background(current_user,@project,@site)
      
    else
      render :action => "index"
    end
  end
    
  def re_deploy
    @site = Site.find(params[:id])

    if @site.path
      @site.status = "Re-deploying!"
      if @site.save
        render :template => "/sites/re_deploy"
        #@site.deploy_on_background(current_user,@site.project,@site.user)
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
    @site.clean_database(@site)
    @site.status = "Cleaning database"
    if @site.save
      render :template => "sites/clean_database"
    else
      redirect_to(@site, :notice => "Database Error. Please contact administrator.")
    end
  end
  
  def uninstall
    @site = Site.find(params[:id])
    @site.status = "Uninstall Application"
    if @site.uninstall(@site)
      @site.save
      render :template => "sites/uninstall"
    else
      redirect_to(@site, :warning => "Uninstall site incomplete!. Please contact administrator.")
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.xml
  def destroy
    @site = Site.find(params[:id])
    
    if @site.uninstall(@site)
      puts "\n\n\n----------- DESTROYED -----------\n\n\n"
      puts "SITE = #{@site.name}"
      
      respond_to do |format|
        format.html { redirect_to(sites_url, :notice => "Your site was successfully deleted.") }
        format.xml  { head :ok }
      end
    else
      redirect_to(@site, :warning => "Remove site incomplete!. Please contact administrator.")
    end
  end
end
