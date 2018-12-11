class Letter < ApplicationRecord
  belongs_to :user

  include AASM
  aasm do
    state :new, initial: true
    state :canceled
    state :in_work
    state :completed

    event :to_canсel do
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
