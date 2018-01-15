namespace :set_slots do
  desc "Set slot ancestry"
  task :tournament, [:tournament_id] => :environment do |t, args|
    tournament = Tournament.find(args[:tournament_id])
    tournament.slots.all.sort_by(&:id).each_with_index do |s, i|
      break if i == 126

      if (i % 2 == 0)
        offset = i/2
      else
        offset = (i - 1)/2
      end
      puts "Child: #{s.id}"
      puts "Parent: #{tournament.slots.sort_by(&:id)[offset + 64].id}"
      s.parent_id = tournament.slots.sort_by(&:id)[offset + 64].id
      s.save

      ## 0 > 64
      #s.parent_id = tournament.slots[i + 64 - ((i+1) %2)].id
      ## 1 > 64
      #s.parent_id = tournament.slots[i + 64 - ((i+1) %2)].id
      ## 2 > 65
      #s.parent_id = tournament.slots[(i/2) + 64].id
      ## 3 > 65
      #s.parent_id = tournament.slots[i + 64 - ((i+1) %2)].id
      # 64 > 96
      # 65 > 96
      # 66 > 97
      # 67 > 97
      # 96 > 112
      # 97 > 112
      # 98 > 113
      # 99 > 113
    end
  end
end
