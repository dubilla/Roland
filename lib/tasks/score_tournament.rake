namespace :score_tournament do
  desc "Update pick winners for a given tournament"
  task :group_tournament, [:group_tournament_id] => :environment do |t, args|
    group_tournament = GroupTournament.find(args[:group_tournament_id])
    group_tournament.entries.each do |e|
      e.picks.each do |p|
        winner = p.slot.matchup.opponents.where(winner: true).first
        if winner.present?
          p.update_attributes(winner: (winner.entrant == p.entrant))
        end
        winner = nil
      end
    end
  end
end
