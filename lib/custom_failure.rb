class CustomFailure < Devise::FailureApp
  def redirect_url

  end

  def respond
    if http_auth?
      http_auth
    else
      redirect_to "/", status: 401
    end
  end
end
