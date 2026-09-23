class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email].to_s.strip.downcase
    name = params[:name].to_s.strip

    if email.blank?
      flash.now[:alert] = "Please enter your email."
      return render :new, status: :unprocessable_entity
    end

    member = Member.find_by(email: email)

    if member.nil?
      if name.blank?
        @email = email
        @needs_name = true
        return render :new, status: :unprocessable_entity
      end
      member = Member.create!(email: email, name: name)
    end

    token = member.generate_auth_token!
    MemberMailer.magic_link(member, token).deliver_later

    redirect_to login_path, notice: "Check your email for a magic link to log in!"
  end

  def verify
    member = Member.find_by(auth_token: params[:token])

    if member&.auth_token_valid?
      member.clear_auth_token!
      session[:member_id] = member.id
      redirect_to session.delete(:return_to) || root_path, notice: "Welcome back, #{member.name}!"
    else
      redirect_to login_path, alert: "This link has expired or is invalid. Please try again."
    end
  end

  def destroy
    session.delete(:member_id)
    redirect_to root_path, notice: "You've been logged out."
  end
end
