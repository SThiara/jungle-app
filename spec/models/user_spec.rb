require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'will succeed if all parameters are provided' do
      @user = User.new(first_name: "Test", last_name: "User", email: "test@user.com", password: "testPassword", password_confirmation: "testPassword")
      expect(@user).to be_valid
    end

    it 'will fail if password and password_confirmation don\'t match' do
      @user = User.new(first_name: "Test", last_name: "User", email: "test@user.com", password: "testPassword1", password_confirmation: "testPassword2")
      expect(@user).to_not be_valid
    end

    it 'will fail if a password is not provided' do
      @user = User.new(first_name: "Test", last_name: "User", email: "test@user.com")
      expect(@user).to_not be_valid
    end
    
    it 'will fail if a first_name is not provided' do
      @user = User.new(last_name: "User", email: "test@user.com", password: "testPassword", password_confirmation: "testPassword")
      expect(@user).to_not be_valid
    end

    it 'will fail if a last_name is not provided' do
      @user = User.new(first_name: "Test", email: "test@user.com", password: "testPassword", password_confirmation: "testPassword")
      expect(@user).to_not be_valid
    end

    it 'will fail if an email is not provided' do
      @user = User.new(first_name: "Test", last_name: "User", password: "testPassword", password_confirmation: "testPassword")
      expect(@user).to_not be_valid
    end

    it 'will fail if a password is fewer than 6 characters' do
      @user = User.new(first_name: "Test", last_name: "User", email: "test@user.com", password_digest: "five5")
      expect(@user).to_not be_valid
    end

    it 'will pass if a password is 6 characters or greater' do
      @user = User.new(first_name: "Test", last_name: "User", email: "test@user.com", password_digest: "six666")
      expect(@user).to be_valid
    end

    it 'will fail if a second user attempts to register with the same email' do
      @user = User.create(first_name: "Test", last_name: "User", email: 'emailAlreadyExists@test.com', password: "testPassword", password_confirmation: "testPassword")
      @user2 = User.new(first_name: "Test", last_name: "User", email: 'emailAlreadyExists@test.com', password: "testPassword", password_confirmation: "testPassword")
      expect(@user2).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'will authenticate if provided an email that already exists with the appropriate password' do
      @user = User.create(first_name: "Test", last_name: "User", email: 'emailAlreadyExists@test.com', password: "testPassword", password_confirmation: "testPassword")
      @user2 = User.authenticate_with_credentials('emailAlreadyExists@test.com', "testPassword")
      expect(@user).to match(@user2) 
    end
    it 'will fail if provided an email that does not exist' do
      @user = User.create(first_name: "Test", last_name: "User", email: 'emailAlreadyExists@test.com', password: "testPassword", password_confirmation: "testPassword")
      expect(User.authenticate_with_credentials('emailDoesNotExist@test.com', "testPassword")).to match(nil) 
    end
  end
end
