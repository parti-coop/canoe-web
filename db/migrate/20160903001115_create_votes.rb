class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :proposal, null: false, index: true
      t.references :user, null: false, index: true
      t.string :choice, null: false
      t.timestamps null: false
    end

    add_index :votes, [:proposal_id, :user_id], unique: true
  end
end
