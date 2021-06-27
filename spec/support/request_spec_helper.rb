# Deviseの設定（A more complicated exampleの方)
# config.include RequestSpecHelper, type: :requestで読み込み（簡易的な方config.include Devise::Test::IntegrationHelpers, type: :requestなら下記不要）
module RequestSpecHelper
  include Warden::Test::Helpers
  def self.included(base)
    base.before(:each) { Warden.test_mode! }
    base.after(:each) { Warden.test_reset! }
  end

  # Devise の sign_in ヘルパーをリクエストスペックで使えるようにする
  def sign_in(resource)
    login_as(resource, scope: warden_scope(resource))
  end
  def sign_out(resource)
    logout(warden_scope(resource))
  end

  private
  def warden_scope(resource)
    resource.class.name.underscore.to_sym
  end
end