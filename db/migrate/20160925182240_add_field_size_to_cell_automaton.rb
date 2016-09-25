class AddFieldSizeToCellAutomaton < ActiveRecord::Migration
  def change
    add_column :cell_automatons, :width, :integer, null: false, default: 1
    add_column :cell_automatons, :height, :integer, null: false, default: 1
  end
end
