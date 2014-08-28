class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable
  validates :username, :fullname, presence: true

  has_many :stats
  has_many :alarms
  has_many :stops

  def remember_me
    true
  end
end
