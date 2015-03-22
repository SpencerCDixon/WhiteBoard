class FamilyInvitation < ApplicationMailer
  default from: "spencercdixon@gmail.com"

  def invite(family_invitation)
    @family_invitation = family_invitation

    mail to: @family_invitation.email,
      subject: 'WhiteBoard Family Invitation',
      content_type: "text/html"
  end
end
