class AddArchivedAtToProposalRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :proposal_requests, :archived_at, :datetime
    add_index :proposal_requests, :archived_at
  end
end
