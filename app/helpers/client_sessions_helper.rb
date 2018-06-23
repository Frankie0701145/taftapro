module ClientSessionsHelper

  #professional
  #method to log in the professional
  def professional_login(professional)
    session[:professional_id]= professional.id
  end
  # Returns the current logged-in professional (if any).
  def current_professional
    @current_professional ||= Professional.find_by(id: session[:professional_id])
  end
  #Returns true if the professional is logged in, false otherwise.
  def professional_logged_in?
    !current_professional.nil?
  end
  #Logs out the current professional
  def professional_logout
    session.delete(:professional_id)
    @current_professional = nil
  end

  #client
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
