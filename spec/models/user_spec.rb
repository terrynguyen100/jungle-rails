require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'POST #create' do
    context 'when password and password_confirmation match' do
      it 'creates a new user' do
        user_params = {
          name: 'John Doe',
          email: 'john@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
        # Approach 1:
        expect{
          User.create(user_params)
        }.to change(User, :count).by(1)

        # Approach 2:

        # expect {
        #   post :create, params: { user: user_params }
        # }.to change(User, :count).by(1)
        # expect(response).to redirect_to('/')
      end
    end

    context 'when password and password_confirmation do not match' do
      it 'does not create a new user' do
        user_params = {
          name: 'John Doe',
          email: 'john@example.com',
          password: 'password123',
          password_confirmation: 'password456' # Different password confirmation
        }

        # Approach 1:
        user = User.create(user_params)
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")

        # Approach 2:
        # expect {
        #   post :create, params: { user: user_params }
        # }.not_to change(User, :count)

        # expect(response).to redirect_to('/signup')
      end
    end

    context 'when email is not unique (case-insensitive)' do
      it 'does not create a new user' do
        existing_user = User.create(
          name: 'John Doe',
          email: 'test@test.com', # Existing user with lowercase email
          password: 'password123',
          password_confirmation: 'password123'
        )

        user_params = {
          name: 'Jane Smith',
          email: 'TEST@TEST.com', # New user with uppercase email
          password: 'password456',
          password_confirmation: 'password456'
        }

        # Approach 1:
        user = User.create(user_params)
        expect(user.errors.full_messages).to include('Email has already been taken')

        # Approach 2:
        # expect {
        #   post :create, params: { user: user_params }
        # }.not_to change(User, :count)

        # expect(response).to redirect_to('/signup')
      end
    end

    context 'when email are missing' do
      it 'does not create a new user' do
        user_params = {
          name: 'Terry',
          email: '',
          password: 'password123',
          password_confirmation: 'password123'
        }
        
        # Aproach 1:
        user = User.create(user_params)
        expect(user.errors.full_messages).to include("Email can't be blank")

        # Approach 2:
        # expect {
        #   post :create, params: { user: user_params }
        # }.not_to change(User, :count)
        # expect(response).to redirect_to('/signup')
      end
    end

    context 'when name are missing' do
      it 'does not create a new user' do
        user_params = {
          name: '',
          email: 'terry@gmail.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
        
        # Aproach 1:
        user = User.create(user_params)
        expect(user.errors.full_messages).to include("Name can't be blank")

        # Approach 2:
        # expect {
        #   post :create, params: { user: user_params }
        # }.not_to change(User, :count)
        # expect(response).to redirect_to('/signup')
      end
    end

    context 'when password does not meet minimum length' do
      it 'does not create new user account' do
        user_params = {
          name: 'Jane Doe',
          email: 'test@test.com',
          password: 'pass',
          password_confirmation: 'pass'
        }
        user = User.create(user_params)
        expect(user.errors.full_messages).to include('Password is too short (minimum is 8 characters)')
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context 'if authenticate succeed' do
      it 'returns the correct user when email and password match' do
        existing_user = User.create(
          name: 'John Doe',
          email: 'test@test.com',
          password: 'password123',
          password_confirmation: 'password123'
        )

        authenticated_user = User.authenticate_with_credentials('test@test.com', 'password123')
        # expect the authenticated user is equivalent to the existing user
        expect(authenticated_user).to eq(existing_user)
      end
    end

    context 'if authentication fails' do
      it 'returns nil when password does not match' do
        existing_user = User.create(
          name: 'John Doe',
          email: 'test@test.com',
          password: 'password123',
          password_confirmation: 'password123'
        )
    
        authenticated_user = User.authenticate_with_credentials('test@test.com', 'wrong_password')
        # expect the authenticated user to be nil when the password does not match
        expect(authenticated_user).to be_nil
      end
    end

    context 'even if there is space in email' do
      it 'authenticate and return the correct user' do
        existing_user = User.create(
          name: 'John Doe',
          email: 'test@test.com',
          password: 'password123',
          password_confirmation: 'password123'
        )

        authenticated_user = User.authenticate_with_credentials('    test@test.com    ', 'password123')
        expect(authenticated_user).to eq(existing_user)
      end
    end

    context 'even if there is wrong case in email' do
      it 'authenticate and return the correct user' do
        existing_user = User.create(
          name: 'John Doe',
          email: 'test@test.com',
          password: 'password123',
          password_confirmation: 'password123'
        )

        authenticated_user = User.authenticate_with_credentials('TEST@tesT.cOM', 'password123')
        expect(authenticated_user).to eq(existing_user)
      end
    end

  end
end