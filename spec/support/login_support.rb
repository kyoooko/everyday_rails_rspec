# ログイン処理をモジュールに切り出す（deviseのヘルパーsign_in userで置き換えられる）
module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end

# ここでincludeせずテスト毎に明示的にサ ポートモジュールを include する方法もあある
RSpec.configure do |config|
  config.include LoginSupport
end