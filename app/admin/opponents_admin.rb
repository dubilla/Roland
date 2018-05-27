Trestle.resource(:opponents) do
  menu do
    item :opponents, icon: "fa fa-star"
  end

   table do
     column :matchup
     column :entrant
     column :created_at, align: :center
     actions
   end

   #form do |opponent|
     #select :matchup, Matchup.all
     #select :entrant, Entrant.all
   #end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:opponent).permit(:name, ...)
  # end
end
