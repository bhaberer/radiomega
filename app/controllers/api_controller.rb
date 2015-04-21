class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def play
    if params.key?(:title) && params.key?(:nick) && params.key?(:artist)
      @nick = params[:nick]
      @song = Song.find_or_create_by(artist: params[:artist], title: params[:title])
      @play = Play.create!(song: @song, nick: params[:nick], time: Time.now)
      @play.update_attribute(:time, params[:time]) if params.key?(:time)
      @play.add_to_set
      respond_with(@play)
    else
      render json: { error: 'Invalid Play data', status: 406 }, status: 406
    end
  end

  def scratch
    if params.key?(:title) && params.key?(:nick) && params.key?(:artist)
      @nick = params[:nick]
      @user = Ircnick.where(nick: @nick).first.user
      fail "No valid user found" unless @user
      @song = Song.find_or_create_by(artist: params[:artist], title: params[:title])
      @play = Play.create!(song: @song, nick: @nick, time: Time.now)
      @play.update_attribute(:time, params[:time]) if params.key?(:time)
      @play.add_to_set(@user.scratch)
      render json: { message: 'Success', status: 200 }, status: 200
    else
      render json: { error: 'Invalid Play data', status: 406 }, status: 406
    end
  end

  def register
    if params.key?(:email) && params.key?(:nick)
      @user = User.find_by_email(params[:email])
      @nick = Ircnick.create(nick: params[:nick], user: @user)
    end

    if @nick.valid?
      respond_with(@nick)
    elsif Ircnick.find_by_nick(params[:nick])
      render json: { error: 'Duplicate Nickname', status: 406 }, status: 406
    elsif @user.nil?
      render json: { error: 'Couldn\'t find email', status: 404 }, status: 404
    else
      render json: { error: 'Missing Registration data', status: 406 }, status: 406
    end
  end

  def nicks
    @nicks = Ircnick.all.map(&:nick)
    render json: @nicks
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
