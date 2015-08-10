class DropUserscourses < ActiveRecord::Migration
  def change
    drop_table :users_courses
  end
end
