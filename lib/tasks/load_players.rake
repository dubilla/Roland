namespace :load_players do
  desc "Load players into db"
  task atp: :environment do
    require "httparty"
    (0 .. 1350).step(50) do |step|
      url = "http://api.espn.com/v1/sports/tennis/athletes?apikey=#{ENV['TENNIS_API_KEY']}&offset=#{step.to_s}"
      response = HTTParty.get(url)
      data = response.parsed_response
      athletes = data["sports"][0]["leagues"][0]["athletes"]
      ActiveRecord::Base.transaction do
        athletes.each do |a|
          player = Player.new(first_name: a["firstName"], last_name: a["lastName"], external_id: a["id"])
          player.save!
          puts a["fullName"]
          puts a["id"]
        end
      end
      puts Player.count
    end
  end
end
