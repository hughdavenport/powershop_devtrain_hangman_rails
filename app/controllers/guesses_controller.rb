class GuessesController < ApplicationController
  before_action :set_game, only: [:create]

  # POST /guesses
  # POST /guesses.json
  def create
    @guess = @game.guesses.create(guess_params)

    respond_to do |format|
      if @guess.save
        format.html { redirect_to @game, notice: 'Guess was successfully created.' }
        format.json { render :show, status: :created, location: @guess }
      else
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
      params.require(:guess).permit(:game_id, :guess)
    end
end
