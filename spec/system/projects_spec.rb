require 'rails_helper'

RSpec.feature "Projects", type: :system do

  it "user creates a new project" do
    user = FactoryBot.create(:user)
	  visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect {
      click_link "New Project"
      fill_in "Name", with: "Test Project"
      fill_in "Description", with: "Trying out Capybara"
      click_button "Create Project"

      expect(page).to have_content "Project was successfully created"
      expect(page).to have_content "Test Project"
      expect(page).to have_content "Owner: #{user.name}"
    }.to change(user.projects, :count).by(1)
  end

  # Capybaraデバッグ
  # ゲストがプロジェクトを追加する
  # it "guest adds a project" do
  #   visit projects_path
  # ❓①できてない：gem launcher使ったが自動では開かれずtmp/capybarを手動で開くことならできる→Rails 5.1と RSpec 3.7以降は多分take_screenshot使うっぽい
  #   save_and_open_page
  #   click_link "New Project"
  # end
end