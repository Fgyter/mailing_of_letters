ActiveAdmin.register Letter do
  scope :state_new
  scope :state_canceled
  scope :state_in_work
  scope :state_completed
end
