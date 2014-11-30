require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "password_reset" do
    let(:user) { create(:user, :password_reset_token => 'anything') }
    let(:mail) { UserMailer.password_reset user }

    it "send user password reset url" do
      expect(mail.subject).to eq("Password Reset")
      expect(mail.to).to eq([user.epost])
      expect(mail.from).to eq(["from@example.com"])
      expect(mail.body.encoded).to match(user_edit_password_path(user.password_reset_token))
    end
  end

end
