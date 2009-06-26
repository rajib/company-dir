class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|

      # Required database fields
      t.string    :login,                 :null => false
      t.string    :crypted_password,      :null => false
      t.string    :password_salt,         :null => false
      t.string    :persistence_token,     :null => false

      # Optional tokens, see Authlogic README for more details.
      # t.string    :single_access_token,   :null => false # or: rss_feed_token

      # Magic columns
      t.integer   :login_count,           :null => false, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip

      # For activating an account, optional
      t.boolean   :active,                :null => false, :default => false

      t.timestamps
    end
  end
  
  def self.down
    drop_table :users
  end
end
