Trestle.resource(:tournaments) do
  menu do
    item :tournaments, icon: "fa fa-star"
  end

   table do
     column :name
     column :start_date
     column :locked
     column :created_at, align: :center
     actions
   end

   form do |tournament|
     text_field :name
     date_field :start_date
     check_box :locked

     #row do
       #col(xs: 6) { datetime_field :updated_at }
       #col(xs: 6) { datetime_field :created_at }
     #end
   end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
   params do |params|
     params.require(:tournament).permit(:name, :start_date, :locked)
   end
end
