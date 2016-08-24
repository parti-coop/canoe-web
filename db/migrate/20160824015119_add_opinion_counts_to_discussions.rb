class AddOpinionCountsToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :opinions_count, :integer, default: 0
  end
end
