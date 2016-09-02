class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
      t.string :title
      t.references :user, null: false
      t.references :proposal_request, null: false, index: true

      t.timestamps null: false
    end
  end
end
