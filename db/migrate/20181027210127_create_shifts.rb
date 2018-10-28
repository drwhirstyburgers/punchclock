class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.timestamp :clock_in
      t.timestamp :clock_out, default: nil
      t.timestamp :date, default: Date.today
      t.boolean :current, default: true
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
