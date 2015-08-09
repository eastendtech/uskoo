class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.string :title
      t.text :details
      t.integer :credit_hours
      t.integer :semester
      t.string :instructor
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
