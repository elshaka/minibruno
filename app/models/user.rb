class User < ActiveRecord::Base
  ROLES = {
    1 => 'Supervisor',
    2 => 'Operador'
  }

  scope :registered, -> { where.not id: 1 }

  devise :database_authenticatable, :rememberable, :trackable, :validatable
  validates :username, uniqueness: true
  validates :username, :fullname, :role_id, presence: true

  has_many :stats
  has_many :alarms
  has_many :stops

  before_destroy :check_assosiations

  def check_assosiations
    stats.empty? and alarms.empty? and stops.empty?
  end

  def update(params)
    if persisted? and params['password'].blank? and params['password_confirmation'].blank?
      params.delete('password')
      params.delete('password_confirmation')
    end
    super(params)
  end

  def admin?
    id == 1
  end

  def remember_me
    not admin?
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
