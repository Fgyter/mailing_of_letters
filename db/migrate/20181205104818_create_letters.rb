class CreateLetters < ActiveRecord::Migration[5.2]
  def change
    create_table :letters do |t|
      t.string :url_address
      t.string :email, index: true
      t.text :comment

      t.timestamps
    end
  end
end
