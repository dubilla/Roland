Trestle.resource(:entrants) do
  menu do
    item :entrants, icon: "fa fa-star"
  end

   table do
     column :player
     column :tournament
     actions
   end
end
