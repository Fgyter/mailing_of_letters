class LettersController < ApplicationController
	before_action :set_letter, only: [:show, :edit, :update, :destroy]

  def index
    @letters = Letter.all
  end

  def show
  end

  def new
    @letter = Letter.new
  end

  def edit
  end

  def create
    @letter = Letter.new(letter_params)
    if @letter.save
      redirect_to @letter       
    else
      render :new
    end
  end

  def update
    if @letter.update(letter_params)
      redirect_to @letter
    else
			render :edit
    end
  end

  def destroy
    if @letter.destroy
			redirect_to letters_path
    end
  end

  private

  def 

  def set_letter
    @letter = Letter.find(params[:id])
    redirect_to letters_path if @letter.nil?
  end

  def letter_params
    params.require(:letter).permit(:url_address, :email, :comment, :user_id)
  end
end
