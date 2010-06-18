class HomeController < ApplicationController
  def index
    
    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @application }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @application }
    end
  end

end
