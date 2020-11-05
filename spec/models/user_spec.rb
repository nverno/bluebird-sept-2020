require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:cool_dude) { User.create(username: 'Cool Dude', age: 40, password: 'password') }

  describe 'validations' do 
    # it 'validates presence of username' do 
    #   incomplete_user = User.new(username: '', age: 10, password: 'password')
    #   expect(incomplete_user).to_not be_valid
    # end

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }

    # must have a subject so that we have something to compare against
    it { should validate_uniqueness_of(:username) }
  end

  describe 'associations' do 
    # do not need to specify through associations
    # it { should belong_to(:association_name) }
    it { should have_many(:chirps) }
    it { should have_many(:likes) }
    it { should have_many(:liked_chirps) }

  end

  describe '#is_password?' do
    # first :user is the local variable name
    # second :user is the name of our factory
    # .create will persist information to the test database
    # .build will instantiate the object, but NOT save it to the db
    let(:user) { FactoryBot.create(:user) }

    context 'with a valid password' do
      it 'should return true' do
        expect(user.is_password?('password')).to be true
      end
    end

    context 'with an invalid password' do 
      it 'should return false' do 
        expect(user.is_password?('hunter12')).to be false
      end
    end
  end

  describe 'password encryption' do
    it 'does not save passwords to the database' do 
      FactoryBot.create(:Harry_Potter)
      user = User.find_by(username: "Harry Potter")
      expect(user.password).not_to eq("starwars")
    end

    it 'encrypts password using BCrypt' do 
      # tests that BCrypt::Password.create('abcdef') is called
      expect(BCrypt::Password).to receive(:create).with('abcdef')
      # we can manually overwrite factory bot column values
      FactoryBot.build(:user, password: 'abcdef')
    end
  end
end
