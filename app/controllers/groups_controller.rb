class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user
    if @group.save
      redirect_to @group
    else
      render 'new'
    end
  end

  def show
    @group = Group.includes(:group_tournaments).find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
