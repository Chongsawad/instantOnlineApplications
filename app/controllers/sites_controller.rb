class SitesController < ApplicationController
  # GET /sites
  # GET /sites.xml
  before_filter :authenticate_user!

  def index
    @sites = current_user.sites

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sites }
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
    @site.path = "/home/inice/InstantSOA/deploy_cap/inice/#{current_user.id}_#{params[:site][:name]}"
    @site.status = "Deploying!"
    @site.user = current_user
    

    respond_to do |format|
      if @site.save
        Delayed::Job.enqueue(DeployingJob.new(current_user, @project, @site))

        format.html { redirect_to(@site, :notice => 'Site was successfully created.') }
        format.xml  { render :xml => @site, :status => :created, :location => @site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  def re_deploy
    @site = Site.find(params[:id])

    if @site.path     
      @site.status = "Re-deploying!"
      @user = @site.user
      @project = @site.project
      
      Delayed::Job.enqueue(DeployingJob.new(@user, @project, @site))

      respond_to do |format|
        if @site.save
          format.html { redirect_to(@site, :notice => "Re-deploying job has already been enqueued. Wait for 5-10 minutes for running process.") }
          format.xml  { head :ok }
        else
          format.html { render :action => "show" }
          format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
        end
      end

    else
      redirect_to(@site, :notice => "ERROR FILE PATH. Please contact administrator.")
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

  def site_destroy(site)
    begin
      puts "\n\n\n----------- SITE_DESTROYING -----------\n\n\n"
      puts "PATH = #{site.path}"
      puts "APPNAME=#{site.user_id}_#{site.name}"

      if system("sh -c 'cd #{site.path}/current/; cap APPNAME=#{site.user_id}_#{site.name} database:drop;'")
        puts "\n----------- Delete Database : #{site.user_id}_#{site.name} -----------\n"

        if system("sh -c 'test -e #{RAILS_ROOT}/site_info/#{current_user.id}_#{site.name}.*'")
          system("sh -c 'rm -Rf #{RAILS_ROOT}/site_info/#{current_user.id}_#{site.name}.*'")
          puts "\n----------- Delete #{RAILS_ROOT}/site_info/#{current_user.id}_#{site.name} -----------\n"

          if system("sh -c 'test -e #{site.path}/'")
            system("sh -c 'rm -Rf #{site.path}'")
            puts "\n----------- Delete #{site.path}   -----------\n"
            return true
          else
            puts "\n----------- Cannot delete application root path --> #{site.path}   -----------\n"
            flash[:warning] = "Cannot delete application root path --> #{site.path}"
            return false
          end

        else
          puts "\n----------- Cannot delete sub-domain the confinguration file --> #{RAILS_ROOT}/site_info/#{current_user.id}_#{site.name} -----------\n"
          return false
        end

      else  
        puts "\n----------- Cannot delete Database : #{site.user_id}_#{site.name} -----------\n"
        return false
      end

    rescue
      puts "\n\n\n----------- DESTROY ERROR!   -----------\n\n\n"
      return false
    end

  end

  # DELETE /sites/1
  # DELETE /sites/1.xml
  def destroy
    @site = Site.find(params[:id])
    
    if site_destroy(@site)
      puts "\n\n\n----------- DESTROYED -----------\n\n\n"
      puts "SITE = #{@site.name}"
      @site.destroy

      respond_to do |format|
        format.html { redirect_to(sites_url, :notice => "Your site was successfully deleted.") }
        format.xml  { head :ok }
      end
    else
      redirect_to(@site, :warning => "Remove site incomplete!. Please contact administrator.")
    end
  end
end
