module HomeHelper
  def name(user)
    "#{user.first_name} #{user.middle_name} #{user.last_name}"
  end
end
