class CreateSailingDiaries < ActiveRecord::Migration
  def change
    create_table :sailing_diaries do |t|
      t.text :body
      t.references :user, null: false
      t.references :canoe, null: false
      t.date :sailed_on
      t.timestamps null: false
    end

    add_index :sailing_diaries, [:canoe_id, :user_id, :sailed_on], unique: true
  end
end
