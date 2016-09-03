class AddVotesCountsToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :agree_votes_count, :integer, default: 0
    add_column :proposals, :block_votes_count, :integer, default: 0
  end
end
