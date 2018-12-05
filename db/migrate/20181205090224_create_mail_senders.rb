class CreateMailSenders < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_senders do |t|
      t.string :employee_name
      t.string :url_address
      t.string :email
      t.string :aasm_state
      t.text :comment
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
