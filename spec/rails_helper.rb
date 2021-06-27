# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
# フィーチャースペックで使用
require 'capybara/rspec'
# ===============ファイルアップロードのテスト===============
# Shoulda Matchers を導入したので、Paperclip がモデルスペック用に提供し ているサポート機能を利用できる、それを有効化
require 'paperclip/matchers'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# rails_helper.rb はきれいな状態を保っておきたいので、R設定ファイルを spec/support ディレクトリに配置するよう設定
# →RSpec.shared_context "project setup" doやカスタムヘルパー、カスタムマッチャなどを定義。spec/supportは rails_helper.rbの拡張したもの。
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # ===============Devise==============================
  # https://github.com/heartcombo/devise/wiki/How-To:-sign-in-and-out-a-user-in-Request-type-specs-(specs-tagged-with-type:-:request)
  # A：Devise のテストヘルパーを使用する(sign_inヘルパーなど、A more complicated exampleの方)
  config.include RequestSpecHelper, type: :request
  # 簡易的に導入するならconfig.include Devise::Test::IntegrationHelpers, type: :requestでもいい
  # B：Devise のテストヘルパーを使用する(sign_inヘルパーなど)
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include Devise::Test::IntegrationHelpers, type: :system
  # =============================================

  # 速くテストを書き、速いテストを書く
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  # ===============ファイルアップロードのテスト===============
  # テストスイートの実行が終わったらアップロードされたファイルを削除する
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_uploads/"])
  end
  # Paperclip の Shoulda Matchers サポートを追加する
  config.include Paperclip::Shoulda::Matchers
end

# ===============❓take_screenshotが真っ白になるため（できなかった）===============
# module SystemHelper
#   extend ActiveSupport::Concern

#   included do |example_group|
#     # Screenshots are not taken correctly
#     # because RSpec::Rails::SystemExampleGroup calls after_teardown before before_teardown
#     example_group.after do
#       take_failed_screenshot
#     end
#   end

#   def take_failed_screenshot
#     return if @is_failed_screenshot_taken
#     super
#     @is_failed_screenshot_taken = true
#   end
# end

# RSpec.configure do |config|
#   config.include SystemHelper, type: :system
# end
