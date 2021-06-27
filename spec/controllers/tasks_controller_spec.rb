# ===============リファクタリング後========================
require 'rails_helper'

RSpec.describe TasksController, type: :controller, focus: true do
  # shared_context
  include_context "project setup"

  describe "#show" do
    it "responds with JSON formatted output" do
      sign_in user
      get :show, format: :json,
        params: { project_id: project.id, id: task.id }
        # カスタムマッチャ
        expect(response).to have_content_type :json
        # expect(response.content_type).to eq "application/json"
    end
  end

  describe "#create" do
    it "responds with JSON formatted output" do
      new_task = { name: "New test task" }
      sign_in user
      post :create, format: :json,
        params: { project_id: project.id, task: new_task }
      # カスタムマッチャ
      expect(response).to have_content_type :json
      # expect(response.content_type).to eq "application/json"
    end

    it "adds a new task to the project" do
      new_task = { name: "New test task" }
      sign_in user
      expect {
        post :create, format: :json,
          params: { project_id: project.id, task: new_task }
      }.to change(project.tasks, :count).by(1)
    end

    it "requires authentication" do
      new_task = { name: "New test task" }
      # Don't sign in this time ...
      expect {
        post :create, format: :json,
          params: { project_id: project.id, task: new_task }
      }.to_not change(project.tasks, :count)
      expect(response).to_not be_success
    end
  end
end
