class User < ActiveRecord::Base
  has_many :pay_requests

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
end
