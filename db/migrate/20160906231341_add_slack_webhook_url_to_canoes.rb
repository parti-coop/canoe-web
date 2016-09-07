class AddSlackWebhookUrlToCanoes < ActiveRecord::Migration[5.0]
  def change
    add_column :canoes, :slack_webhook_url, :string
  end
end
