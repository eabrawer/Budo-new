class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :username
    	t.string :email
    	t.string :password_digest
    	t.string :picture
    	t.string :country
    	t.string :state
    	t.string :city
    	t.text :biography
    	t.timestamps
    end
  end
end
