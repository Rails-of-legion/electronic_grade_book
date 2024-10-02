class ExpelUserJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.where(expelled: true)

    if user&.expelled && user.expelled_at && user.expelled_at <= 1.minute.ago
      user.destroy
    end
  end
end
