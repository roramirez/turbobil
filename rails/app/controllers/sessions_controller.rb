class SessionsController < Devise::SessionsController
  layout "blank"

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_customer_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    customer_calls_path
  end


end
