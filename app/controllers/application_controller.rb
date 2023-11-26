class ApplicationController < ActionController::API
  def pagination_params
    params.permit(:limit, :offset, :is_count)
  end
end
