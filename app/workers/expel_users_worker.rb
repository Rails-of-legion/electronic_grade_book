# app/workers/expel_users_worker.rb
class ExpelUsersWorker
  include Sidekiq::Worker

  def perform
    User.where(expelled: true).where('expelled_at < ?', Time.current - 1.minute).find_each do |user|
      user.destroy
    end
  end
end
