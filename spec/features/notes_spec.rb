require 'rails_helper'

# ファイルアップロードのテスト
RSpec.feature "Notes", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:project) {
    FactoryBot.create(:project,
      name: "RSpec tutorial",
      owner: user)
  }

  scenario "user uploads an attachment" do
    sign_in user
    visit project_path(project)
    click_link "Add Note"
    fill_in "Message", with: "My book cover"
    attach_file "Attachment", "#{Rails.root}/spec/files/attachment.jpg"
    click_button "Create Note"
    expect(page).to have_content "Note was successfully created"
    expect(page).to have_content "My book cover"
    expect(page).to have_content "attachment.jpg"
  end
  # ❓できない
  # Shoulda Matchers を導入＋rails_helper.rbで設定したので１行でかける
  # it { is_expected.to have_attached_file(:attachment) }
end