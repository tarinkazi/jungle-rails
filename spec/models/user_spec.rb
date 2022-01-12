require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    user = User.new(
        name: "Tarin",
        email: "test@test.com",
        password: "test",
        password_confirmation: "test"
      )

    it "should create a valid user" do
      expect(user).to be_valid
    end

    it "should have a name to be valid user" do
      user.name = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include "Name can't be blank"
    end

    it "should have an email to be valid user" do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include "Email can't be blank"
    end

    it "should have a password with a min length of 3 to be valid user" do
      user.password = "te"
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include "Password is too short (minimum is 3 characters)"
    end

    it "should have a password and password confirmation" do
      user.password_confirmation= nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include "Password confirmation can't be blank"
    end

    it "should have a matching password and password confirmation" do
      user.password_confirmation= "test2"
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    context 'should not have 2 users with same email' do
      user2 = User.new(
        name: "user2",
        email: "test@test.COM",
        password: "test",
        password_confirmation: "test"
      )
      it { is_expected.to_not be_valid } 
    end

  end

  describe '.authenticate_with_credentials' do
    let!(:user) { User.create!(name: 'Tarin', email: 'test@test.com', password: 'test', password_confirmation: 'test') }

    it 'should return nil if authentication fails' do
      result = User.authenticate_with_credentials('tarin@test.com', 'test')
      expect(result).to be_nil
    end

    it 'should return the user if authentication passes' do
      result = User.authenticate_with_credentials('test@test.com', 'test')
      expect(result).to be_present
    end

    it 'is valid with whitespace before or after email' do
      result = User.authenticate_with_credentials(' test@test.com ', 'test')
      expect(result).to be_present
    end
    
    it 'is valid regardless of casing in email' do
      result = User.authenticate_with_credentials(' test@tEsT.com ', 'test')
      expect(result).to be_present
    end
   
  end
  
end