class CreateLifegames < ActiveRecord::Migration
  def change
    create_table :lifegames do |t|
      t.integer :board_size
      t.integer :step
      t.integer :state_num
      t.integer :init_type 
      t.integer :state_count_range
      t.integer :live_count_min
      t.integer :live_count_max
      t.integer :retention_count_min
      t.integer :retention_count_max

      t.timestamps null: false
    end
  end
end
