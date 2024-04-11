# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    clear_aliased_actions
    assign_permissions_by_role(user)
  end

  private

  def clear_aliased_actions
    CanCan::Ability.aliased_actions.clear
  end

  def assign_permissions_by_role(user)
    case user.try(:role)
    when 'admin' then assign_admin_permissions(user)
    when 'teacher' then assign_teacher_permissions(user)
    when 'student' then assign_student_permissions(user)
    else assign_guest_permissions(user) if user.has_no_roles?
    end
  end

  def assign_admin_permissions(user)
    assign_permissions(user, :admin, :manage)
  end

  def assign_teacher_permissions(user)
    # assign_permissions(user, :teacher, :update, Article, :read, Comment)
  end

  def assign_student_permissions(user)
    # assign_permissions(user, :student, :update, Article, :read, Comment)
  end

  def assign_guest_permissions(user)
    # assign_permissions(user, nil, :read, :all) if user.has_no_roles?
  end

  def assign_permissions(user, role, *args)
    can(*args) if user.has_role?(role)
  end
end
