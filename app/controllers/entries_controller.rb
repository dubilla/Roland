class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    group_tournament = GroupTournament.find(params[:group_tournament_id])
    @entry = group_tournament.entries.build(entry_params)
    @entry.user = current_user
    if @entry.save
      redirect_to @entry.group_tournament
    else
      render 'new'
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:name)
  end
end
