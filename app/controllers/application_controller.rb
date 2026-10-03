class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :set_current_member

  private

  def set_current_member
    Current.member = Member.find_by(id: session[:member_id]) if session[:member_id]
  end

  def authenticate_member!
    unless Current.member
      session[:return_to] = request.fullpath
      redirect_to login_path, alert: "Please log in to continue."
    end
  end

  def require_admin!
    authenticate_member!
    return if performed?
    unless Current.member&.admin?
      redirect_to root_path, alert: "Not authorized."
    end
  end
end
