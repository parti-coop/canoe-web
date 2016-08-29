class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false
      t.references :canoe, null: false
      t.timestamps null: false
    end

    add_index :memberships, [:user_id, :canoe_id], unique: true
  end
end
