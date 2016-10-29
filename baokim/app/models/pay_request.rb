class PayRequest < ActiveRecord::Base
  after_create :create_data

  belongs_to :user

  validates :card_id, presence: true
  validates :pin_field, presence: true
  validates :seri_field, presence: true

  private
  def create_data
    self.merchant_id = Settings.merchant_id
    self.api_username = Settings.api_username
    self.api_password = Settings.api_password
    self.transaction_id = self.id
    self.algo_mode = "hmac"

    rawData = self.algo_mode + self.api_password + self.api_username +
      self.card_id + self.merchant_id + self.pin_field + self.seri_field +
      self.transaction_id
    key = Settings.secure_pass
    self.data_sign = OpenSSL::HMAC.hexdigest("SHA1", key, rawData)

    self.save
  end
end
