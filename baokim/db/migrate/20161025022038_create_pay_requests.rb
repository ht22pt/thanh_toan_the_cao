class CreatePayRequests < ActiveRecord::Migration
  def change
    create_table :pay_requests do |t|
      t.string :merchant_id
      t.string :api_username
      t.string :api_password
      t.string :transaction_id
      t.string :card_id
      t.string :pin_field
      t.string :seri_field
      t.string :algo_mode
      t.string :data_sign
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
