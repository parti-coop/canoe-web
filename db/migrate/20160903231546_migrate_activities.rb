class MigrateActivities < ActiveRecord::Migration[5.0]
  def up
    ActiveRecord::Base.transaction do
      Opinion.all.each do |opinion|
        Activity.new(user: opinion.user,
          discussion: opinion.discussion,
          trackable: opinion,
          action: 'opinions/create',
          created_at: opinion.created_at,
          updated_at: opinion.created_at).save
      end

      Vote.all.each do |vote|
        Activity.new(user: vote.user,
          discussion: vote.discussion,
          trackable: vote,
          action: "votes/#{vote.choice}",
          created_at: vote.updated_at,
          updated_at: vote.updated_at).save
      end
    end
  end
end
