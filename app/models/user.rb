class User < ActiveRecord::Base
  serialize :parameters
  
  has_one :level
  
  acts_as_authentic { |c| c.crypto_provider = Authlogic::CryptoProviders::BCrypt }

  validates_uniqueness_of :first_name, :last_name
  
  preserve_attributes_if_nil :password

  def activate!
    self.active = true
    save
  end
  
  # all mail
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end
