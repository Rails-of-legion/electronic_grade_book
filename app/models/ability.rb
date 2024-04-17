class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    elsif user.teacher?
      can :manage, Subject
      can :manage, User
      can :manage, RecordBook
      can :read, Group
      can :read, Notification
      can :read, Semester
      can :read, Specialization
      can :read, Student
      can :read, TeachersSubject
      can :read, Grade
      can :read, Group
      can :read, IntermediateAttestation
    elsif user.student?
      can :read, Subject
      can :read, User
      can :read, RecordBook
      can :read, Group
      can :read, Notification
      can :read, Semester
      can :read, Specialization
      can :read, Student
      can :read, TeachersSubject
      can :read, Grade
      can :read, Attendance
    else
      cannot :manage, :all
    end
  end
end
