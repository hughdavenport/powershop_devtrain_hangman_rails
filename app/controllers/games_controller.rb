class GamesController < ApplicationController
  before_action :set_game, only: [:show, :destroy]

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # POST /games
  # POST /games.json
  def create
    service = CreateGame.new(game_params)

    respond_to do |format|
      if @game = service.call
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :ok, location: @game }
      else
        @game = service.game
        format.html { render :new } # not edit as first time only
        format.json { render json: @errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:starting_lives, :wordlist_name).map { |k, v| [k.to_sym, v] }.to_h
    end
end
