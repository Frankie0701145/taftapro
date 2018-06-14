module ClientSessionsHelper

  #method to log in the client
  def client_login(client)
    session[:client_id]= client.id
  end

  # Returns the current logged-in client (if any).
  def current_client
    @current_client ||= Client.find_by(id: session[:client_id])
  end

  #Returns true if the client is logged in, false otherwise.
  def client_logged_in?
    !current_client.nil?
  end

  #Logs out the current client
  def client_logout
    session.delete(:client_id)
    @current_client = nil
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
