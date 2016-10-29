class User < ActiveRecord::Base
  has_many :pay_requests
  has_many :pay_responds

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
end
