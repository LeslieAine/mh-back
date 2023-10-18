# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
      return unless user.present?
      can :read, :all
      return unless user.admin?
      can :manage, :all

      if user.client?
        # can :read, :all
        can :like, Post
        can :bookmark, Post
     elsif user.creator?
    #   can :read, :all
      can :create, Post
      can :like, Post
      can :bookmark, Post
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
  end
end
