class MigrateMembershipsOfCanoeCreator < ActiveRecord::Migration[5.0]
  def up
    Canoe.all.each do |canoe|
      canoe.memberships.create(user: canoe.user)
    end
  end
end
