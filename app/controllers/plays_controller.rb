# Controller managing plays
class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :edit, :update, :destroy]

  def index
    @setlists = Setlist.where(type: nil)
    @songs = Song.youtubed
  end

  def show
  end

  def new
    redirect_to plays_path, notice: 'That action is not allowed currently'
  end

  def edit
  end

  def create
    redirect_to plays_path, notice: 'That action is not allowed currently'
  end

  def update
    respond_to do |format|
      if @play.update(play_params)
        format.html do
          redirect_to @play, notice: 'play was successfully updated.'
        end
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    redirect_to plays_path, notice: 'That action is not allowed currently'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = Song.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the
  #   white list through.
  def song_params
    params.require(:song).permit(:title, :artist)
  end
end
