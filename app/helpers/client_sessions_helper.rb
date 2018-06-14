module ClientSessionsHelper

  #method to log in the client
  def client_login(client)
    session[:client_id]= client.id
  end

  # Returns the current logged-in client (if any).
  def current_client
    @current_client ||= Client.find_by(id: session[:client_id])
  end


  #Logs out the current client
  def client_logout
    session.delete(:client_id)
    @current_client = nil
  end

end
