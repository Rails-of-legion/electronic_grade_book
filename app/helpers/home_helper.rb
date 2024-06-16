module HomeHelper
  def name(user)
    "#{user.last_name} #{user.first_name} #{user.middle_name} "
  end
end
