class EntrantsController < ApplicationController
  def new
    @entrant = Entrant.new
    @tournaments = Tournament.all
    @players = Player.all
  end

  def create
    @entrant = Entrant.new(entrant_params)
    if @entrant.save
      redirect_to entrants_path
    else
      render "new"
    end
  end

  def index
    @entrants = Entrant.all
  end

  private

  def entrant_params
    params.require(:entrant).permit(:player_id, :tournament_id)
  end
end
