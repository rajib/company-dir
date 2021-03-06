class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
