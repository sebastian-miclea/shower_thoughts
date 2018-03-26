class ThoughtsController < ApplicationController
  
  def show
    posts = Post.all.order('created_at DESC').limit(20)
    render json: posts.map{ |p| p.to_json }
  end

  def update
    PostsLoaderJob.perform_later
  end
end