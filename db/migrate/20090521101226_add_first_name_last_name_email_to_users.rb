class AddFirstNameLastNameEmailToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :perishable_token, :string, :default => "", :null => false
  end

  def self.down
    remove_column :users, :email
    remove_column :users, :last_name
    remove_column :users, :first_name
    remove_column :users, :perishable_token
  end
end
