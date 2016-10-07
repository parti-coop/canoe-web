class CreateEmotionTags < ActiveRecord::Migration[5.0]
  def change
    create_table :emotion_tags do |t|
      t.references :emotion, index: true, null: false
      t.references :sailing_diary, index: true, null: false
      t.timestamps null: false
    end

    add_index :emotion_tags, %i{emotion_id sailing_diary_id}, unique: true
  end
end
