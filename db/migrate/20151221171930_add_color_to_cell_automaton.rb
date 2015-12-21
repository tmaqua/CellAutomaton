class AddColorToCellAutomaton < ActiveRecord::Migration
  def change
    add_column :cell_automatons, :colors, :text
  end
end
