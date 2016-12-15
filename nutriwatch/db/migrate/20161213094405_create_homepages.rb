class CreateHomepages < ActiveRecord::Migration
  def change
    create_table :homepages do |t|
      t.string :d_name
      t.string :r_name
      t.integer :c_min
      t.integer :c_max
      t.integer :r_min
      t.integer :r_max
      t.integer :p_min
      t.integer :p_max

      t.timestamps null: false
    end
  end
end
