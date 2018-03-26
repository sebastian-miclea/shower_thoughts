require 'spec_helper'

describe TokenController, type: :controller do

  before(:all) do 
    @client = Client.create(name: 'Client one')
  end

  context 'refresh_token' do
    it 'creates a fresh token if client exists' do
      post :refresh_token, params: { client_id: @client.id }
      expect(response.status).to eq(201)
    end

    it 'responds with 404 if client does not exist' do
      post :refresh_token, params: { client_id: 0 }
      expect(response.status).to eq(404)
    end
  end
end