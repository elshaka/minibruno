class SupervisorPolicy < ApplicationPolicy
  def index?
    user.supervisor?
  end

  def create?
    user.supervisor?
  end

  def update?
    user.supervisor?
  end
end
