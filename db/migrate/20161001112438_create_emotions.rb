class CreateEmotions < ActiveRecord::Migration[5.0]
  def change
    create_table :emotions do |t|
      t.string :sign
      t.string :slug
      t.timestamps null: false
    end
  end
end
