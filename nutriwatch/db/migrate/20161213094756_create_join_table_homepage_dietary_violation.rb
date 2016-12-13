class CreateJoinTableHomepageDietaryViolation < ActiveRecord::Migration
  def change
    create_join_table :Homepages, :DietaryViolation do |t|
      # t.index [:homepage_id, :dietaryviolation_id]
      # t.index [:dietaryviolation_id, :homepage_id]
    end
  end
end
