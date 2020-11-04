require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'get#new' do 

    it 'renders our new user template' do 
      get :new
      expect(response).to render_template(:new)
    end

  end

  describe 'post#create' do 
    let(:valid_params) { { user: { username: 'Cooler Dude', age: 41, password: 'password' } } }
    let(:invalid_params) {  { user: { username: 'Cooler Dude', age: 41, password: '' } }}

    # let variables in RSpec are lazily instantiated.  ie: the user variable isn't created and assigned until we call user later in the code (user.session_token)
    # the block of code will be run each time we reference the user variable
    
    let(:user) { User.find_by(username: 'Cooler Dude') }

    context 'with valid params' do 
      before :each do 
        post :create, params: valid_params
      end 

      it 'logs in the user' do 
        expect(session[:session_token]).to eq(user.session_token)
      end

      it 'redirects to users show page' do
        expect(response).to redirect_to(user_url(user))
      end
    end

    context 'with invalid params' do

      it 'renders the new template' do 
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end

  end

end
