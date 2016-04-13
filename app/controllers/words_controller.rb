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
  def create
    @word = @word_list.words.new(word_params)

    if @word.save
      redirect_to @word_list, notice: 'Word was successfully created.'
    else
      render :new
    end
  end

  # DELETE /word_list/:word_list_id/words/1
  def destroy
    @word.destroy
    redirect_to word_list_path(@word_list, params.slice(:page)), notice: 'Word was successfully destroyed.'
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
