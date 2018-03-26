class TokenController < ActionController::API
  def refresh_token
    client = Client.find_by(id: params[:client_id])
    if client
      token = JsonWebToken.encode({client_id: client.id})
      render json: { fresh_token: token }, status: 201
    else
      render json: {}, status: 404
    end
  end
end