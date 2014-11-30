require 'rails_helper'

RSpec.describe User do
  describe "#send_password_reset" do
    let(:user) { create(:user) }

    it "generate a unique send_password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      expect(user.password_reset_token).not_to eq(last_token)
    end

    it " saves the time the password reset was sent" do
      user.send_password_reset
      user.reload
      expect(user.password_reset_sent_at).to be_present
    end

    it "Delivers email to user" do
      user.send_password_reset
      expect(last_email.to).to include user.epost
    end
  end
end
