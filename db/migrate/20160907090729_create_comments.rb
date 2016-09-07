class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, index: true
      t.references :opinion, null: false, index: true
      t.text :body
      t.timestamps null: false
    end
  end
end
