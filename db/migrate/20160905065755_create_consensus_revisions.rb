class CreateConsensusRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :consensus_revisions do |t|
      t.references :discussion, null: false, index: true
      t.references :user, null: false, index: true
      t.text :body
      t.timestamps null: false
    end
  end
end
