class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy, :to_cancel, :to_work, :to_completed]

  def page
    if user_signed_in?
      redirect_to letters_path
    end
  end

  def index
    @letters = current_user.letters

    dates = params[:date] || {}
    @letters = @letters.where("created_at >= ?", dates[:start_date]) if dates[:start_date]
    @letters = @letters.where("created_at <= ?", dates[:end_date]) if dates[:end_date]
    @letters = @letters.where(aasm_state: params[:aasm_state]) if params[:aasm_state]

    @letters_month = current_user.letters.where(created_at: Time.now.beginning_of_month..Time.now).group(:aasm_state).count
  end

  def search_email
    @letters = Letter.all.order(id: :desc)
    @message = @letters.search_by_email(params[:q]).present? ? t(:record_already_exists) : t(:you_can_create_an_entry)
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

  def letter_statistics
    @letters = current_user.letters.last_half_year.order(:created_at).group_by { |q| q.created_at.strftime("%B") }
    .map do |month, letters|
      [
        month, letters.group_by(&:aasm_state)
          .map { |key, status| [key, status.count] }
      ]
    end
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