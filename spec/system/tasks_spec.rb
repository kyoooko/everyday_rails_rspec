# システムスペック移行
require 'rails_helper'

RSpec.feature "Tasks", type: :system, focus: true do
  # JSのテスト（タスクの終了チェックしたら線が引かれる）
  # webサービスのテストでVCR gemを導入したのでVCR::Errors::UnhandledHTTPRequestError.new(vcr_request)となる場合は,vcr: trueが必要
  it "user toggles a task",vcr: true, js: true do
    # 下記コメントアウトしテストを失敗させる
    # user = FactoryBot.create(:user)
    project = FactoryBot.create(:project,
      name: "RSpec tutorial",
      owner: user)
    task = project.tasks.create!(name: "Finish RSpec tutorial")
    # Rails 5.1と RSpec 3.7以降シミュレート中のブラウザの 画像を作成（tmp/screenshots）→JavaScript ドライバ(本書でいうところの selenium-webdriver)を使うテストでしか使用できない
    # ❓③スクショが白紙
    # ちなみにこれか書かなくてもスクショ作成された
    take_screenshot
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    click_link "RSpec tutorial"
    check "Finish RSpec tutorial"

    expect(page).to have_css "label#task_#{task.id}.completed"
    expect(task.reload).to be_completed

    uncheck "Finish RSpec tutorial"

    expect(page).to_not have_css "label#task_#{task.id}.completed"
    expect(task.reload).to_not be_completed
  end
end

