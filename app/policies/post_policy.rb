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
      return scope.where(published: true).or(user.posts) if user.writer?
      return scope.all if user.moderator?
    end
  end
end
