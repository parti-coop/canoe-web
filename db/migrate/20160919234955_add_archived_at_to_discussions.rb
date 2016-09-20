class AddArchivedAtToDiscussions < ActiveRecord::Migration[5.0]
  def change
    add_column :discussions, :archived_at, :datetime
    add_index :discussions, :archived_at
  end
end
