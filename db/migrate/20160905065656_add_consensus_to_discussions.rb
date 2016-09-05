class AddConsensusToDiscussions < ActiveRecord::Migration[5.0]
  def change
    add_column :discussions, :consensus, :text
  end
end
