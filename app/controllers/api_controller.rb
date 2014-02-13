class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def play
    if params.key?(:title) && params.key?(:nick) && params.key?(:artist)
      @nick = params[:nick]
      @song = Song.find_or_create_by_artist_and_title(params[:artist],
                                                      params[:title])
      @play = Play.create!(song: @song, nick: params[:nick])
      @play.add_to_set
      respond_with(@play)
    else
      render json: { error: "Invalid Play data", status: 406 }
    end
  end
end
