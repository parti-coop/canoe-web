class CreateProposalRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :proposal_requests do |t|
      t.text :title
      t.references :user, null: false
      t.references :discussion, null: false, index: true

      t.timestamps null: false
    end
  end
end
