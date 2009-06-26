class ActivationsController < ApplicationController
  before_filter :require_no_user
  before_filter :find_user_by_activation_code
  
  def new
    respond_to do |format|
    format.html{  }
    end   
  end

  def create
    respond_to do |format|
      if @user.activate!         
        @user.deliver_activation_confirmation!
        format.html { redirect_to login_path }
      else
        format.html { render :action => :new }
      end
    end
  end
  
  protected
    def find_user_by_activation_code
      @user = User.find_using_perishable_token(params[:activation_code], 1.week)
      redirect_to root_path unless @user
    end
end
