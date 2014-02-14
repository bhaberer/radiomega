class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :edit, :update, :destroy]

  def index
    @setlists = Setlist.all
    @songs = Song.youtubed
  end

  def show
  end

  def new
    @play = Play.new
  end

  def edit
  end

  def create
    @play = Play.new(play_params)

    respond_to do |format|
      if @play.save
        format.html { redirect_to @play, notice: 'play was successfully created.' }
        format.json { render action: 'show', status: :created, location: @play }
      else
        format.html { render action: 'new' }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @play.update(play_params)
        format.html { redirect_to @play, notice: 'play was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = Song.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    params.require(:song).permit(:title, :artist)
  end
end
