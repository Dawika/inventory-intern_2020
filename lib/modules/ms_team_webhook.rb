require 'uri'
require 'net/http'

module MsTeamWebhook
  def send_webhook(text, title = nil)
    if Figaro.env.TEAM_CONNECTOR_WEBHOOK_URL?
      teams = Teams.new(Figaro.env.TEAM_CONNECTOR_WEBHOOK_URL)
      teams.post(text, title: title)
    end
  end
end
