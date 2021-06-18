source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
# gem "mimemagic", "~> 0.3.10"

gem 'rails', '~> 5.1.1'
gem 'sqlite3'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # フィーチャースペック（デフォルトで入ってる）
  gem 'selenium-webdriver'
  # Rspec
  # gem 'rspec-rails', '~> 3.6.0'
  # システムスペック導入のため3.7以降にバージョンアップ
  gem 'rspec-rails', '~> 3.8.0'
  # テストデータ
  gem "factory_bot_rails", "~> 4.10.0"
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'faker', require: false # for sample data in development
  # テストスイートの起動時間を速くする
  gem 'spring-commands-rspec'
end

group :test do
  # フィーチャースペック
  gem 'capybara', '~> 2.15.4'
  # Chrome とやりとりするインターフェース
  gem 'webdrivers'
  # ブラウザが自動で開く
  gem 'launchy', '~> 2.4.3'
  # 速くテストを書き、速いテストを書く
  gem 'shoulda-matchers',
    git: 'https://github.com/thoughtbot/shoulda-matchers.git',
    branch: 'rails-5'

  # Webサービスのテスト（API連携できてるか）を早くする
  gem 'vcr'
  gem 'webmock'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'devise'
gem 'paperclip'
gem 'geocoder'
