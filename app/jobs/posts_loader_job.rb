class PostsLoaderJob < ApplicationJob
  after_perform do |job|
    self.class.set(:wait => 1.hour).perform_later
    PostCleanerJob.perform_later
  end

  def perform
    posts = RedditClient.new.load_posts
    new_posts = []
    posts.each do |post|
      post_data = post['data']
      if post_data && post_data.is_a?(Hash)
        new_posts << Post.new(post_id: post_data.try(:[], 'id'), body: post_data.to_json)
      end
    end

    Post.import(new_posts.select{ |p| p.valid? })
  end
end