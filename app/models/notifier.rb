class Notifier < ActionMailer::Base
  def password_reset_instructions(user)  
    setup_email(user)
    subject       "Password Reset Instructions"  
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end  
  
  def activation_instructions(user)
    setup_email(user)
    subject       "Fill Out Your Detail And Activate Your Account"
    body          :account_activation_url => new_activation_url(:activation_code => user.perishable_token)
  end

  def activation_confirmation(user)
    setup_email(user)
    subject       "Your Detail Stored And Activation Completed"
    body          :user => user, :root_url => root_url
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "Solaro <support@solaro.com>"
      headers "Reply-to" => "support@solaro.com"
      @subject     = "[Solaro] "
      @sent_on     = Time.now
      @content_type = "text/html"      
      @body[:user] = user
    end
end
