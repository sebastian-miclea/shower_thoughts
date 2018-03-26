class ApplicationController < ActionController::API
  before_action :validate_token

  private 

  def validate_token
    if request.headers['Authorization'].present? 
      begin
        payload = JsonWebToken.decode(request.headers['Authorization'])
        client = Client.find_by(id: payload['client_id'])
        raise InvalidToken, 'Client Not Found' unless client
      rescue InvalidToken

        empty_response(401)
      end
    else
      empty_response(401)
    end
  end

  def empty_response(status)
    render json: {}, status: status
  end
end
