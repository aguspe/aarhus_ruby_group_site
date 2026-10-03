class MemberMailer < ApplicationMailer
  def magic_link(member, token)
    @member = member
    @url = verify_url(token)
    mail(to: member.email, subject: "Your login link for Aarhus Ruby Group")
  end

  private

  def verify_url(token)
    auth_verify_url(token: token)
  end
end
