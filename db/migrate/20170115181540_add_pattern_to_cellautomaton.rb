class AddPatternToCellautomaton < ActiveRecord::Migration
  def change
    add_column :cell_automatons, :pattern, :boolean, null: false, default: false
  end
end
