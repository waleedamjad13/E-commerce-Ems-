module AuthorizeUser
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    protect_from_forgery with: :exception
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_back(fallback_url: root_path)
  end
end
