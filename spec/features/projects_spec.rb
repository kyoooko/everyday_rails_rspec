# =======システムスペック移行したのでコメントアウト=======
require 'rails_helper'

RSpec.feature "Projects", type: :feature do

  scenario "user creates a new project" do
    user = FactoryBot.create(:user)
    # ①もともと
	  # visit root_path
    # click_link "Sign in"
    # fill_in "Email", with: user.email
    # fill_in "Password", with: user.password
    # click_button "Log in"
    # ②モジュールに切り出す（spec/support/login_support.rb）
    # sign_in_as user
    # ③deviseのヘルパー
    sign_in user
    visit root_path

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

  # # Capybaraデバッグ
  # # ゲストがプロジェクトを追加する
  # it "guest adds a project" do
  #   visit projects_path
  # # ❓①できてない：gem launcher使ったが自動では開かれずtmp/capybarを手動で開くことならできる→Rails 5.1と RSpec 3.7以降は多分take_screenshot使うっぽい
  #   save_and_open_page
  #   click_link "New Project"
  # end

  # ===================テスト駆動開発（正常系：プロジェクトを完了できるようにする）==========================
  # ユーザーは新しいプロジェクトを作成する
  scenario "user creates a new project", focus: true do
    # プロジェクトを持ったユーザーを準備する
    user = FactoryBot.create(:user)
    project = project = FactoryBot.create(:project, owner: user)
    # ユーザーはログインしている
    sign_in user
    # ユーザーがプロジェクト画面を開き
    visit project_path(project)

    # 追加
    # Completedが表示されていないこと
    expect(page).to_not have_content "Completed"

    # "complete" ボタンをクリックすると
    click_button "Complete"

    # =================テスト駆動開発===================
    # 一時的に Launchy をテストに組み込む
    # save_and_open_page

    # プロジェクトは完了済みとしてマークされる
    expect(project.reload.completed?).to be true
    # フラッシュメッセージ表示
    expect(page).to \
      have_content "Congratulations, this project is complete!"
    # Completedが表示される
    expect(page).to have_content "Completed"
    # ボタンが消える
    expect(page).to_not have_button "Complete"
  end

  # ユーザーはプロジェクトを完了済みにする
  scenario "user completes a project"
end