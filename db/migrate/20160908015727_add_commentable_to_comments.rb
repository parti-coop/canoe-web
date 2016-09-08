class AddCommentableToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :commentable, polymorphic: true, index: true

    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          UPDATE comments
             SET commentable_id = opinion_id,
                 commentable_type = 'Opinion'
        SQL
      end

      dir.down do
        execute <<-SQL.squish
          UPDATE comments
             SET opinion_id = commentable_id
        SQL
      end
    end

    change_column_null :comments, :commentable_id, false
    change_column_null :comments, :commentable_type, false

    remove_column :comments, :opinion_id
  end
end
