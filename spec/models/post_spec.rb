require 'spec_helper'

describe Post, type: :model do

  before(:each) do
    Post.create(post_id: '12345', body: '{"subreddit_id":"t5_2szyo","approved_at_utc":null}')
  end

  context 'to_json' do
    it 'extracts body as hash' do
      post = Post.first
      expect(post.to_json).to eq({'subreddit_id' => 't5_2szyo', 'approved_at_utc' => nil})
    end
  end

end