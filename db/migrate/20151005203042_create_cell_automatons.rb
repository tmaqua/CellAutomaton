class CreateCellAutomatons < ActiveRecord::Migration
  def change
    create_table :cell_automatons do |t|
      t.string :name
      t.integer :board_size
      t.integer :step
      t.integer :state_num
      t.integer :init_type
      t.text :neighbor_rule

      t.timestamps null: false
    end
  end
end
