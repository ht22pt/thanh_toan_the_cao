class CreatePayRequests < ActiveRecord::Migration
  def change
    create_table :pay_requests do |t|
      t.string :func
      t.string :version
      t.string :merchant_id
      t.string :merchant_account
      t.string :merchant_password
      t.string :pin_card
      t.string :serial_card
      t.string :type_card
      t.string :ref_code
      t.string :client_fullname
      t.string :client_email
      t.string :client_mobile
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
