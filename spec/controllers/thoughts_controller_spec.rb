require 'spec_helper'

describe ThoughtsController, type: :controller do
  describe 'authorized' do
    before(:all) do
      25.times do |i|
        Post.create(post_id: "12345#{i}", body: '{"subreddit_id":"t5_2szyo","approved_at_utc":null}')
      end
      client = Client.create
      @token = JsonWebToken.encode(client_id: client.id)
    end

    context 'show' do
      it 'responds with 200' do
        request.headers.merge(Authorization: @token)
        get :show
        expect(response.status).to eq(200)
      end

      it 'returns 20 shower thoughts' do
        request.headers.merge(Authorization: @token)
        get :show
        body = Yajl::Parser.parse(response.body)

        expect(body.count).to eq(20)
      end
    end

    context 'update' do
      it 'responds with 200' do
        request.headers.merge(Authorization: @token)
        patch :update
        expect(response.status).to eq(204)      
      end

      it 'calls PostsLoaderJob' do  
        request.headers.merge(Authorization: @token)
      
        expect(PostsLoaderJob).to receive(:perform_later)

        patch :update
      end
    end
  end

  describe 'unauthorized' do
    before(:all) do
      @client = Client.create
    end
    it 'responds with 401 when client is missing' do
      token = JsonWebToken.encode(client_id: @client.id + 1)
      request.headers.merge(Authorization: token)

      get :show
      expect(response.status).to eq(401)
    end

    it 'responds with 401 when token is invalid' do
      request.headers.merge(Authorization: '12345.1234.123')

      get :show
      expect(response.status).to eq(401)
    end

    it 'responds with 401 for expired tokens' do
      Timecop.freeze
      
      token = JsonWebToken.encode(client_id: @client.id)
      request.headers.merge(Authorization: token)
      
      Timecop.travel(Time.now + 9.hours)
      
      get :show
      expect(response.status).to eq(401)

      Timecop.return
    end
  end
end