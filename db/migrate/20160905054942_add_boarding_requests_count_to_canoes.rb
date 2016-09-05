class AddBoardingRequestsCountToCanoes < ActiveRecord::Migration[5.0]
  def change
    add_column :canoes, :boarding_requests_count, :integer, default: 0

    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          UPDATE canoes
             SET boarding_requests_count = (SELECT count(1)
                                              FROM boarding_requests
                                             WHERE boarding_requests.canoe_id = canoes.id)
        SQL
      end
    end
  end
end
