class WordsController < ApplicationController
  before_action :set_word_list
  before_action :set_word, only: [:destroy]

  # GET /word_list/:word_list_id/words/new
  def new
    @word = @word_list.words.new
  end

  # GET /word_list/:word_list_id/words
  def index
    redirect_to @word_list
  end

  # POST /word_list/:word_list_id/words
  # POST /word_list/:word_list_id/words.json
  def create
    @word = @word_list.words.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word_list, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /word_list/:word_list_id/words/1
  # DELETE /word_list/:word_list_id/words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to @word_list, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word_list
      @word_list = WordList.find(params[:word_list_id])
    end

    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:word)
    end
end
