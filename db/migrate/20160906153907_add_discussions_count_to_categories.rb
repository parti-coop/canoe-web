class AddDiscussionsCountToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :discussions_count, :integer, default: 0

    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          UPDATE categories
             SET discussions_count = (SELECT count(1)
                                        FROM discussions
                                       WHERE discussions.category_id = categories.id)
        SQL
      end
    end
  end
end
