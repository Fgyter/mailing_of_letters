class Letter < ApplicationRecord
  belongs_to :user

  scope :search_by_email, -> (e_mail) { where email: e_mail }
  scope :last_half_year, -> { where('created_at > ?', Date.today.months_ago(6)) }

  include AASM
  aasm do
    state :new, initial: true
    state :canceled
    state :in_work
    state :completed

    event :to_cancel do
      transitions from: [:new, :in_work], to: :canceled
    end

    event :to_work do
      transitions from: [:new], to: :in_work
    end

    event :to_completed do
      transitions from: [:in_work], to: :completed
    end
  end
end
