class GraphqlController < ApplicationController
  protect_from_forgery prepend: true

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: get_current_user
    }
    result = PlockSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )
    render json: result
    rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: {
      error: {
        message: e.message,
        backtrace: e.backtrace
      },
      data: {}
    }, status: 500
  end

  def get_current_user
    authorization = request.headers['Authorization']
    token = authorization.split(' ').last if authorization
    begin
      decoded = JsonWebToken.decode(token)
      user_data = JSON.parse(Base64::decode64(decoded["user_data"]))
      User.find(user_data['user_id'])
    rescue => exception
      nil
    end
  end
end
