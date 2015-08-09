class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state, limit: 2
      t.string :zip_code, limit: 10
      t.integer :role

      t.timestamps null: false
    end
  end
end
