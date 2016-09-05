class AddStrokedAtToDiscussions < ActiveRecord::Migration[5.0]
  def change
    add_column :discussions, :stroked_at, :datetime

    reversible do |dir|
      dir.up do
        ActiveRecord::Base.connection.execute "UPDATE discussions SET stroked_at = updated_at"
        change_column_null :discussions, :stroked_at, false
      end
    end
  end
end
