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

  def manage
    @sites = current_user.sites
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

    # site_path is the destination path which store all of resource of this site
    # site_path should be the same as the path in capistrano file(cap file)
    @site.path = "/home/inice/InstantSOA/deploy_cap/inice/#{current_user.id}_#{params[:site][:name]}"
    @site.status = "Deploying!"
    @site.user = current_user
    
    @project = Project.find(@site.project_id)

    # Delayed::Job.enqueue(DeployingJob.new(current_user, @project, @site))

    respond_to do |format|
      if @site.save
        format.html { redirect_to(@site, :notice => 'Site was successfully created.') }
        format.xml  { render :xml => @site, :status => :created, :location => @site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
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

  # DELETE /sites/1
  # DELETE /sites/1.xml
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to(sites_url) }
      format.xml  { head :ok }
    end
  end
end
