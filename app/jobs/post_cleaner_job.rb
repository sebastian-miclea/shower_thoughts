class PostCleanerJob < ApplicationJob
  def perform
    Post.where('created_at < ?', Time.now - 3.hours).destroy_all
  end
end