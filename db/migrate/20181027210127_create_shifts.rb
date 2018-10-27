class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.timestamp :clock_in
      t.timestamp :clock_out
      t.timestamp :date

      t.timestamps
    end
  end
end
