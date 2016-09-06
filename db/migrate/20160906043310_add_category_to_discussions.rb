class AddCategoryToDiscussions < ActiveRecord::Migration[5.0]
  def change
    add_reference :discussions, :category, index: true

    reversible do |dir|
      dir.up do
        transaction do
          Canoe.all.each do |canoe|
            execute <<-SQL.squish
              UPDATE discussions
                 SET category_id = #{canoe.categories.base.id}
               WHERE canoe_id = #{canoe.id}
            SQL
          end
        end
      end
    end

    change_column_null :discussions, :category_id, false
  end
end
