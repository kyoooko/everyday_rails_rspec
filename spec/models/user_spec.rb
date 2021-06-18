require 'rails_helper'

RSpec.describe User, type: :model do
  #=============バリデーションのテスト==============
  # 姓、名、メール、パスワードがあれば有効な状態であること
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  # 下記と同じ
  # it "is valid with a first name, last name, email, and password" do
  #   user = User.new(
  #     first_name: "Aaron",
  #     last_name:  "Sumner",
  #     email:      "tester@example.com",
  #     password:   "dottle-nouveau-pavilion-tights-furze",
  #   )
  #   expect(user).to be_valid
  # end

  # 名がなければ無効な状態であること
  it "is invalid without a first name" do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end
  # 下記と同じ
  # it "is invalid without a first name" do
  #   user = User.new(first_name: nil)
  #   user.valid? #これ必要
  #   # expect(user).not_to be_valid
  #   expect(user.errors[:first_name]).to include("can't be blank")
  # end

  # 姓がなければ無効な状態であること
  it "is invalid without a last name" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end
  # 下記と同じ
  # it "is invalid without a last name" do
  #   user = User.new(last_name: nil)
  #   user.valid?
  #   expect(user.errors[:last_name]).to include("can't be blank")
  # end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  # 下記と同じ
  # it "is invalid without an email address" do
  #   user = User.new(email: nil)
  #   user.valid?
  #   expect(user.errors[:email]).to include("can't be blank")
  # end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "aaron@example.com")
    user = FactoryBot.build(:user, email: "aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  # 下記と同じ
  # it "is invalid with a duplicate email address" do
  #   User.create(
  #     first_name:  "Joe",
  #     last_name:  "Tester",
  #     email:      "tester@example.com",
  #     password:   "dottle-nouveau-pavilion-tights-furze",
  #   )
  #   user = User.new(
  #     first_name:  "Jane",
  #     last_name:  "Tester",
  #     email:      "tester@example.com",
  #     password:   "dottle-nouveau-pavilion-tights-furze",
  #   )
  #   user.valid?
  #   expect(user.errors[:email]).to include("has already been taken")
  # end

  #=============メソッドのテスト==============
  # ユーザーのフルネームを文字列として返すこと
  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: "John", last_name: "Doe")
    expect(user.name).to eq "John Doe"
  end
  # 下記と同じ
  # it "returns a user's full name as a string" do
  #   user = User.new(
  #     first_name: "John",
  #     last_name:  "Doe",
  #     email:      "johndoe@example.com",
  #   )
  #   expect(user.name).to eq "John Doe"
  # end

  #=============Webサービスのテスト（API連携できてるか）==============
  # ジオコーディングを実行すること
  it "performs geocoding", vcr: true do
    user = FactoryBot.create(:user, last_sign_in_ip: "161.185.207.20")
    expect {
      user.geocode
    }.to change(user, :location).
      from(nil).
      # to("Brooklyn, New York, US")
      # ではなく
      to("New York City, New York, US")
  end
end


#=============速くテストを書き、速いテストを書く==============
# it { is_expected.to validate_presence_of :name }
# it { is_expected.to have_many :dials }
# it { is_expected.to belong_to :compartment }
# it { is_expected.to validate_uniqueness_of :serial_number }
