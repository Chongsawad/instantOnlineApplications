class DeploymentsController < ApplicationController
  before_filter :authenticate_admin!
  
  def index
    @deployments = Deployment.all
  end
  
  def show
    @deployment = Deployment.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @deployment }
    end
  end
  
  def edit
    @deployment = Deployment.find(params[:id])
  end
  
  def update
    @deployment = Deployment.find(params[:id])
    
    respond_to do |format|
      if @deployment.update_attributes(params[:deployment])
        
        format.html { redirect_to(@deployment, :notice => 'Config parameter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deployment.errors, :status => :unprocessable_entity }
      end
    end
  end

end
