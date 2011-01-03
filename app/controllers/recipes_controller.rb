class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @recipe }
    end
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to(@recipe.deployment, :notice => 'Recipe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
end
