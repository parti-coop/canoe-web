class CreateEmotionsSailingDiaries < ActiveRecord::Migration[5.0]
  def change
    create_table :emotions_sailing_diaries do |t|
      t.references :emotion, index: true, null: false
      t.references :sailing_diary, index: true, null: false
      t.timestamps null: false
    end

    add_index :emotions_sailing_diaries, [:emotion_id, :sailing_diary_id], unique: true, name: :emotions_sailing_diaries_unique
  end
end
