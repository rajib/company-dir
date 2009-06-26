class ChangeActiveDefaultToUsers < ActiveRecord::Migration
  def self.up
    change_column_default :users, :active, false
  end

  def self.down
    change_column_default :users, :active, true
  end
end
