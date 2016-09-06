class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.references :canoe, null: false, index: true
      t.references :user, null: false, index: true
      t.string :name, null: false
    end

    reversible do |dir|
      dir.up do
        transaction do
          Canoe.all.each do |canoe|
            execute <<-SQL.squish
              INSERT INTO categories(canoe_id, user_id, name)
                   VALUES (#{canoe.id}, #{canoe.user.id}, '#{Category::DEFAULT_NAME}')
            SQL
          end
        end
      end
    end
  end
end
