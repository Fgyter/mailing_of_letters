class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy, :to_cancel, :to_work, :to_completed]

  def page
    if user_signed_in?
      redirect_to letters_path
    end
  end

  def index
    @letters = current_user.letters.order(id: :desc)
  end

  def show
  end

  def new
    @letter = Letter.new
  end

  def edit
  end

  def create
    @letter = current_user.letters.build(letter_params)
    if @letter.save
      redirect_to letters_path
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

  def to_cancel
    @letter.to_cancel!
    redirect_to @letter
  end

  def to_work
    @letter.to_work!
    redirect_to @letter
  end

  def to_completed
    @letter.to_completed!
    redirect_to @letter
  end

  private

  def set_letter
    @letter = Letter.find(params[:id])
    redirect_to letters_path if @letter.nil?
  end

  def letter_params
    params.require(:letter).permit(:url_address, :email, :comment, :user_id, :aasm_state)
  end
end