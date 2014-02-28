class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def play
    if params.key?(:title) && params.key?(:nick) && params.key?(:artist)
      @nick = params[:nick]
      @song = Song.find_or_create_by_artist_and_title(params[:artist],
                                                      params[:title])
      @play = Play.create!(song: @song, nick: params[:nick], time: Time.now)
      @play.update_attribute(:time, params[:time]) if params.key?(:time)
      @play.add_to_set
      respond_with(@play)
    else
      render  json: { error: 'Invalid Play data', status: 406 },
              status: 406
    end
  end

  def start
    title = params[:title]
    owner = params[:owner].downcase
    if title && owner
      @ended = Setlist.end_for_owner(owner)
      @setlist = Setlist.create!(owner: owner, title: title)
      @setlist.start
      respond_with(@setlist)
    else
      render  json: { error: 'Invalid Data', status: 406 },
              status: 406
    end
  end

  def end
    owner = params[:owner].downcase
    if owner
      @setlist = Setlist.where(owner: owner, live: true).first
      if @setlist
        @setlist.end
        respond_with(@setlist)
      else
        render  json: { error: 'No set running for that user', status: 404},
                status: 404
      end
    else
      render  json: { error: 'Invalid Data', status: 406 },
              status: 406
    end
  end
end
