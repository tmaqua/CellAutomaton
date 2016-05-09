class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.string :color
      t.integer :cell_automaton_id

      t.timestamps null: false
    end
  end
end
