class CreateJoinTableHomepageDietaryViolations < ActiveRecord::Migration
  def change
  	drop_join_table :homepage, :dietaryviolation 
    create_join_table :homepage, :dietaryviolation do |t|
      t.index [:homepage_id, :dietary_violation_id]
      t.index [:dietary_violation_id, :homepage_id]
    end
  end
end
