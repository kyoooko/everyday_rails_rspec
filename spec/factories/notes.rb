FactoryBot.define do
  factory :note do
    message "My important note."
    association :project
    user { project.owner }
    # 下記だと、projectに関連するnoteとuserに関連するnoteが同一にならなず２つ作られる
    # association :user
  end
end
