class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.references :user, null: false
      t.references :canoe, null: false
      t.string :title
      t.string :body
      t.timestamps null: false
    end

    add_index :discussions, [:canoe_id, :user_id]
  end
end
