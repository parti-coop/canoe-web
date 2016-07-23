class CreateBoardingRequests < ActiveRecord::Migration
  def change
    create_table :boarding_requests do |t|
      t.references :user, null: false
      t.references :canoe, null: false
      t.datetime :accepted_at
      t.references :acceptor
      t.timestamps null: false
    end

    add_index :boarding_requests, [:user_id, :canoe_id], unique: true
  end
end
