# Songs Controller
class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]

  def index
    @songs = Song.all
  end

  def show
  end

  def new
    redirect_to songs_path, notice: 'That action is not allowed currently'
  end

  def edit
  end

  def create
    redirect_to songs_path, notice: 'That action is not allowed currently'
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    logger.debug "#{current_user} deleted song ##{@song.id}"
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = Song.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    params.require(:song).permit(:title, :artist, :youtube_id)
  end
end
