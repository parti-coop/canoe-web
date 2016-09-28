class CreateWikis < ActiveRecord::Migration[5.0]
  def change
    create_table :wikis do |t|
      t.string :title, null: false
      t.text :body
      t.references :canoe, null: false
      t.timestamps null: false
    end
  end
end
