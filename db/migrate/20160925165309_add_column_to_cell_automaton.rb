class AddColumnToCellAutomaton < ActiveRecord::Migration
  def change
    add_column :cell_automatons, :user_id, :integer, null: false, default: 0
    add_column :cell_automatons, :init_rule, :text, null: false, default: ""
  end
end
