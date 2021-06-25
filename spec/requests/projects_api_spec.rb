require 'rails_helper'
describe 'Projects API', type: :request do
  # 1件のプロジェクトを読み出すこと
it 'loads a project' do
    user = FactoryBot.create(:user)
    # プロジェクト①
    FactoryBot.create(:project,
      name: "Sample Project")
    # プロジェクト②（userA)
    FactoryBot.create(:project,
      name: "Second Sample Project",
      owner: user)
    # index:プロジェクト一覧にuserAでログインしつつアクセス
    get api_projects_path, params: {
      user_email: user.email,
      user_token: user.authentication_token
    }
    # Response はブラウザに返すべきアプリケーションの全データを保持しているオブジェクトです
    expect(response).to have_http_status(:success)
    # JSON(ジェイソン)形式の文字列（テキスト）をハッシュに変換
    json = JSON.parse(response.body)
    # userAで認証したのでプロジェクト②のみ
    expect(json.length).to eq 1
    # show:プロジェクト詳細にuserAでログインしつつアクセス
    project_id = json[0]["id"]
    get api_project_path(project_id), params: {
      user_email: user.email,
      user_token: user.authentication_token
    }
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json["name"]).to eq "Second Sample Project"
    # などなど
  end

  # post:プロジェクトを作成できること
  it 'creates a project' do
    user = FactoryBot.create(:user)
    # FactoryBot.attributes_for(:project) は プロジェクトファクトリからテスト用の属性値をハッシュとして作成します。
    project_attributes = FactoryBot.attributes_for(:project)
    expect {
      post api_projects_path, params: {
        user_email: user.email,
        user_token: user.authentication_token,
        project: project_attributes
      }
    }.to change(user.projects, :count).by(1)
    expect(response).to have_http_status(:success)
  end
end
