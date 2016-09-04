class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false, index: true
      t.references :trackable, polymorphic: true, null: false, index: true, unique: true
      t.references :discussion, null: false, index: true
      t.string :action, null: false
      t.timestamps null: false
    end
  end
end
