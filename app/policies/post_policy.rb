# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def create?
    user.writer?
  end

  def update?
    user.writer? && record.user == user
  end

  def destroy?
    user.writer? && record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
