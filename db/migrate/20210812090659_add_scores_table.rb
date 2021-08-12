class AddScoresTable < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.string :player
      t.integer :score
      t.datetime :time

      t.timestamps
    end

    add_index :scores, :player
    add_index :scores, :time
  end
end
