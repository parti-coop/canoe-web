class AddNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string

    query = "UPDATE users SET nickname = id"
    ActiveRecord::Base.connection.execute query
    say query

    change_column_null :users, :nickname, false
  end
end
