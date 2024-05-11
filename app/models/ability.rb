class Ability
  include CanCan::Ability

  def initialize(user)
    clear_abilities

    return define_guest_abilities unless user

    define_admin_abilities if user.has_role?(:admin)
    define_teacher_abilities if user.has_role?(:teacher)
    define_student_abilities if user.has_role?(:student)
  end

  private

  def clear_abilities
    @rules = []
  end

  def define_guest_abilities
    def define_guest_abilities
      can :read, :all
    end
  end

  def define_admin_abilities
    can :manage, :all
  end

  def define_teacher_abilities
    can :read, Group
    can :read, Specialization
    can :read, User
  end

  def define_student_abilities
    can :read_notifications, User, id: user.id
  end
end
