module ApplicationHelper
  include Pagy::Frontend

  def user_role_translation(user)
    case user.roles.first.name
    when 'admin' then t('home.admin')
    when 'teacher' then t('home.teacher')
    when 'student' then t('home.student')
    else user.roles.first.name
    end
  end
end
