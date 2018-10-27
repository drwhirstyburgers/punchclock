class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :working, default: false

      t.timestamps
    end
  end
end
