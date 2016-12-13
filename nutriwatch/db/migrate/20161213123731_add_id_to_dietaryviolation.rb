class AddIdToDietaryviolation < ActiveRecord::Migration
  def change
    add_column :dietaryviolations, :id, :primary_key
  end
end
