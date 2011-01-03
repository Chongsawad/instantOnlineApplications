class ConfigParametersController < ApplicationController
  def show
    @config = ConfigParameter.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @config }
    end
  end
  
  def edit
    @config = ConfigParameter.find(params[:id])
  end
  
  def update
    @config = ConfigParameter.find(params[:id])

    respond_to do |format|
      if @config.update_attributes(params[:config_parameter])
        
        format.html { redirect_to(@config.deployment, :notice => 'Config parameter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @config.errors, :status => :unprocessable_entity }
      end
    end
  end
end
