class SetlistsController < ApplicationController
  before_action :set_setlist, only: [:show, :edit, :update, :destroy]

  def index
    @setlists = Setlist.all
  end

  def show
  end

  def new
    redirect_to setlists_path, notice: 'That action is not allowed currently'
  end

  def edit
  end

  def create
    redirect_to setlists_path, notice: 'That action is not allowed currently'
  end

  def update
    respond_to do |format|
      if @setlist.update(setlist_params)
        format.html { redirect_to @setlist, notice: 'Setlist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @setlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    redirect_to setlists_path, notice: 'That action is not allowed currently'
  end

  def last
    redirect_to Setlist.last
  end

  def today
    redirect_to Setlist.last
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_setlist
    @setlist = Setlist.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def setlist_params
    params[:setlist]
  end
end
