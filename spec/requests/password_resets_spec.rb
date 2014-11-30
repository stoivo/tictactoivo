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
  end

  it "updates the user password when confirmation matches" do
    user = create(:user, password_reset_token: "something", password_reset_sent_at: 1.hour.ago)

    # user = Factory(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago)
    # visit edit_password_reset_path(user.password_reset_token)
    visit user_edit_password_path user.password_reset_token
    fill_in "Password", :with => "foobar"
    click_button "Update Password"
    # page.should have_content("Password doesn't match confirmation")
    expect(page).to have_selector('div', 'alert.alert-dismissable.alert-danger')
    fill_in "Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"
    click_button "Update Password"
    expect(page).to have_content("Password has been reset")
  end

  it "reports when password token has expired" do
    user = create(:user, password_reset_token: "something", password_reset_sent_at: 5.hour.ago)
    # user = Factory(:user, :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
    visit user_edit_password_path(user.password_reset_token)
    fill_in "Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"
    click_button "Update Password"
    expect(page).to have_content("Password reset has expired")
  end

  it "raises record not found when password token is invalid" do
    expect(lambda {
      visit user_edit_password_path("invalid")
    }).to raise_exception(ActiveRecord::RecordNotFound)
  end

end
