class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.string :name
      t.float :value
      t.integer :cell_automaton_id

      t.timestamps null: false
    end
  end
end
