# =========フィーチャースペック=========
# =====EveryRails本文通り（❓②できてない）====================
# Chrome を使うように設定（デフォルトはFirefox）
# Capybara.javascript_driver = :selenium_chrome
# Chrome のヘッドレスモード
# Capybara.javascript_driver = :selenium_chrome_headless
# 15秒待つことをデフォルトにする（デフォルトは2秒）
# 本当に遅い処理を実行する場合は都度using_wait_time(15) do ~ endとする
# Capybara.default_max_wait_time = 15


# =========システムスペックに書き換え=========
# =========EveryRails本文通り====================
RSpec.configure do |config|
  # config.include Capybara::DSL # 追記RSpec 3.7以降
  config.before(:each, type: :system) do
    driven_by :rack_test # driven_byはフィーチャースペックでは使えない
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end

# ======調べた（❓できてない）==================================
# RSpec.configure do |config|
#   # selenium-webdriver
#   # 名前は任意。
#   Capybara.register_driver :selenium_chrome do |app|
#     Capybara::Selenium::Driver.new(app, browser: :chrome)
#   end
#   Capybara.javascript_driver = :selenium_chrome
#   # 常時使用の場合は Capybara.default_driver = :selenium_firefox

#   # headless
#   # config.before(:all) do
#   #   # デフォルトだとウインドウサイズが心もとないので大きくしときます。
#   #   @headless = Headless.new(dimensions: "1920x1080x24")
#   #   @headless.start
#   # end

#   # config.after(:all) do
#   #   @headless.destroy
#   # end
# end

