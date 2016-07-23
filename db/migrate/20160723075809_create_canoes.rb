class CreateCanoes < ActiveRecord::Migration
  def change
    create_table :canoes do |t|
      t.string :title, null: false
      t.text :body
      t.references :user, null: false
      t.string :logo
      t.timestamps null: false
    end
  end
end
