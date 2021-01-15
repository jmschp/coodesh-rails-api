class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end

  # def api_status?
  #   false
  # end
end
