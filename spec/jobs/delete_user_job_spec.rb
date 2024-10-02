class DeleteUserJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    if user && user.expelled_at && user.expelled && (Time.current - user.expelled_at) >= 1.minute
      user.destroy
    end
  end
end
