class GamesController < ApplicationController
  before_action :set_game, only: [:show, :destroy]

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
  end

  # POST /games
  def create
    service = CreateGame.new(game_params)

    if @game = service.call
      redirect_to @game, notice: 'Game was successfully created.'
    else
      @game = service.game
      @errors = service.errors
      render :new # not edit as first time only
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
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
