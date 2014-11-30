require 'rails_helper'

RSpec.describe "PasswordResets", :type => :request do
  it "emails user when requested password reset" do
    user = create(:user)
    visit login_path
    click_link "password"
    fill_in "Epost", :with => user.epost
    click_button "Reset password"
    expect(current_path).to eq games_path
    expect(page).to have_content "Email sent"
    expect(last_email.to).to include user.epost

    # puts ActionMailer::Base.deliveries.inspect
    # ActionMailer::Base.deliveries = []
    # puts ActionMailer::Base.deliveries.inspect
    # last_email.shoud have_content user.epost
  end
  it "do not emails invalid user when requested password reset" do
    user = create(:user)
    visit login_path
    click_link "password"
    fill_in "Epost", :with => "somthingthatnobodyuse@scruit.com"
    click_button "Reset password"
    expect(current_path).to eq games_path
    expect(page).not_to have_content "Email sent"
    expect(page).to have_content "No uses"
    expect(last_email).to be_nil

    # puts ActionMailer::Base.deliveries.inspect
    # ActionMailer::Base.deliveries = []
    # puts ActionMailer::Base.deliveries.inspect
    # last_email.shoud have_content user.epost
  end

end
