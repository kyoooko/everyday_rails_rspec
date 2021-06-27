# shared_contextの定義
# spec/rails_helper.rbでDir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }を設定している

RSpec.shared_context "project setup" do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }
  let(:task) { project.tasks.create!(name: "Test task") }
end