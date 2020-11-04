class UsersController < ApplicationController
  before_action :require_logged_in, only: [:index, :show]

    def index
        @users = User.all # rails does some stuff under the hood to pass it to the view
        # render json: users
        render :index

        # if no explicit render/redirect,
        # rails assumes you want to render a template of same name as action
    end

    def show
        # instance variables get passed to the view templates
        @user = User.find(params[:id])
        # render json: user
        render :show
    end

    def new
        @user = User.new # empty user object so our form doesn't break
        render :new
    end

    def create
        # debugger
        @user = User.new(user_params)
        
        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            # render json: user.errors.full_messages, status: 422
            render :new # still have access to @user instance variable for this view
            # redirect_to new_user_url
            # render :new
        end
    end

    def edit
        @user = User.find_by(id: params[:id]) # returns nil if not found

        if @user
            render :edit
        else
            render json: 'not there', status: 404
        end
    end

    def update
        @user = User.find(params[:id]) # throws exception if not found

        if @user.update(user_params)
            redirect_to user_url(@user)
        else
            # render json: @user.errors.full_messages, status: 422
            render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])

        @user.destroy
        redirect_to users_url 
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :age)
    end
end