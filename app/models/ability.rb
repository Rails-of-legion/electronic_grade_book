class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # гостевой пользователь (не залогинен)

    if user.has_role? :admin
      # can :manage, :all
    elsif user.has_role? :teacher
      # can :update, Article
      # can :read, Comment
    elsif user.has_role? :student
      # can :update, Article
      # can :read, Comment
    else
      can :read, :all
    end
  end
end
