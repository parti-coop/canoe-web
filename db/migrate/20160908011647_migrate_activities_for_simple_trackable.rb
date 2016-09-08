class MigrateActivitiesForSimpleTrackable < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL.squish
      UPDATE activities
         SET action = 'opinion'
       WHERE trackable_type = 'Opinion'
    SQL
  end
end
