# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    define_abilities_for_role(user.role, user)
  end

  private

  def define_abilities_for_role(role, user)
    case role
    when 'admin' then define_admin_abilities
    when 'teacher' then define_teacher_abilities(user)
    when 'student' then define_student_abilities
    else define_guest_abilities
    end
  end

  def define_admin_abilities
    can :all, :all
  end

  def define_teacher_abilities(user)
    # can :manage, Post, user_id: user.id
    # can :read, Comment
  end

  def define_student_abilities
    # can :read, :all
  end

  def define_guest_abilities
    # can :read, Post
  end
end