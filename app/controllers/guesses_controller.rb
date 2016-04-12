class GuessesController < ApplicationController
  before_action :set_game

  # GET /games/:game_id/guesses
  def index
    redirect_to @game
  end

  # POST /games/:game_id/guesses
  # POST /guesses.json
  def create
    service = SubmitGuess.new(@game, guess_params[:guess])

    respond_to do |format|
      if service.call
        format.html { redirect_to @game, notice: 'Guess was successfully created.' }
        format.json { render :show, status: :created, location: @guess }
      else
        @errors = service.errors
        format.html { render "games/show", object: @game }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
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
