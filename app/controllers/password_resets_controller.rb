class PasswordResetsController < ApplicationController
  before_filter :require_no_user  
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]  
  
  def new
     respond_to do |format|
       format.html {  }
     end
   end

   def create
     @user = User.find_by_email(params[:email])     
     respond_to do |format|
       if @user
         @user.deliver_password_reset_instructions!
         flash[:notice] = "Instructions to reset your password have been emailed to you. " +
          "Please check your email."
         format.html { redirect_to root_url }
        else
          #@user_session = UserSession.new()
          flash[:notice] = "No user was found with that email address"
          format.html{ render :action => :new }
       end
     end
   end
   
  def edit  
    respond_to do |format|
      format.html {  }
    end 
  end  
  
  def update  
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    respond_to do |format|
      if @user.save_without_session_maintenance
        flash[:notice] = "Password successfully updated"       
        format.html { redirect_to root_url }
      else
        format.html { render :action => :edit }
      end
    end  
  end  

  
  private  
    def load_user_using_perishable_token  
      @user = User.find_using_perishable_token(params[:id])  
        unless @user  
          flash[:notice] = "We're sorry, but we could not locate your account. " +  
          "If you are having issues try copying and pasting the URL " +  
          "from your email into your browser or restarting the " +  
          "reset password process."  
          redirect_to root_url  
        end  
    end
end
