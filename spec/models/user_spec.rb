require 'rails_helper'

describe User do
  # [X] It should have a unique email
  # [X] It should have a valid email
  # [X] It should have a unique username
  # [X] It should have a either a member or admin role

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:role) }

  it "should have a unique email" do
    expect {
      FactoryGirl.create(
      :user, email: "test3@test.com"
      )
    }.to_not raise_error
    expect {
      FactoryGirl.create(
      :user, email: "test3@test.com"
      )
    }.to raise_error
  end

  it "should have a valid email" do
    expect {
      FactoryGirl.create(
      :user, email: "test3@test"
      )
    }.to raise_error
    expect {
      FactoryGirl.create(
      :user, email: "@test.com"
      )
    }.to raise_error
  end

  it "should have a role in 'member' or 'admin'" do
    expect {
      FactoryGirl.create(
      :user, role: "user"
      )
    }.to raise_error
    expect {
      FactoryGirl.create(
      :user, role: "member"
      )
    }.to_not raise_error
    expect {
      FactoryGirl.create(
      :user, role: "admin"
      )
    }.to_not raise_error
  end
end
