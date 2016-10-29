class PayRequest < ActiveRecord::Base
  before_create :create_data

  belongs_to :user

  validates :serial_card, presence: true
  validates :pin_card, presence: true
  validates :type_card, presence: true

  private
  def create_data
    self.func              = Settings.func
    self.version           = Settings.version
    self.merchant_id       = Settings.merchant_id
    self.merchant_account  = Settings.merchant_account
    self.merchant_password = Digest::MD5.hexdigest(Settings.merchant_id +
      "|" + Settings.merchant_password)
    self.ref_code          = Time.now.to_s
    self.client_fullname   = self.user.fullname
    self.client_email      = self.user.email
    self.client_mobile     = self.user.mobile
  end
end
