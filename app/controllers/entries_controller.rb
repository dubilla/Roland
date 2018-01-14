class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    group_tournament = GroupTournament.find(params[:group_tournament_id])
    @entry = group_tournament.entries.build(entry_params)
    @entry.user = current_user
    @entry.tournament.slots.each do |s|
      @entry.picks.build(slot: s)
    end
    if @entry.save
      redirect_to @entry.group_tournament
    else
      render 'new'
    end
  end

  def show
    @entry = Entry.includes(picks: { slot: { matchup: :entrants } } ).find(params[:id])
  end

  def destroy
    entry = Entry.find(params[:id])
    entry.destroy
    flash[:success] = "Entry deleted"
    redirect_to entry.group_tournament
  end

  private

  def entry_params
    params.require(:entry).permit(:name)
  end
end
