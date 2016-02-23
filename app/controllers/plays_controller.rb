# Controller managing plays
class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:destroy]

  def index
    @setlists = Setlist.where(type: nil).paginate(page: params[:page], per_page: 10)
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
    logger.debug "#{current_user} deleted play ##{@play.id}"
    @play.destroy
    respond_to do |format|
      format.html { redirect_to plays_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_play
    @play = Play.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the
  #   white list through.
  def play_params
    params.require(:play).permit(:song_id, :nick)
  end
end
