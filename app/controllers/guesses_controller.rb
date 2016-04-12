class GuessesController < ApplicationController
  before_action :set_game

  # GET /games/:game_id/guesses
  def index
    redirect_to @game
  end

  # POST /games/:game_id/guesses
  def create
    service = SubmitGuess.new(@game, guess_params[:guess])

    if service.call
      redirect_to @game, notice: 'Guess was successfully created.'
    else
      @errors = service.errors
      render "games/show", object: @game
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guess_params
      params.require(:guess).permit(:guess)
    end
end
