# frozen_string_literal: true

module Api::V1
  class UsersController < ::Api::BaseController
    before_action :set_user, only: %i[show edit update destroy]

    # GET /users
    def index
      @users = User.all
    end

    # GET /users/1
    def show
      render json: UserBlueprint.render(@user)
    end

    # GET /users/1/edit
    def edit; end

    # POST /users
    def create
      user = User.new(user_params)

      raise Errors::CustomError.new(:bad_request, 400, user.errors.messages) unless user.save

      render json: UserBlueprint.render(user)
    end

    # PATCH/PUT /users/1
    def update
      unless @user.update(user_params)
        raise Errors::CustomError.new(:bad_request, 400, @user.errors.messages)
      end

      render json: UserBlueprint.render(@user)
    end

    # DELETE /users/1
    def destroy
      @user.destroy
      render json: UserBlueprint.render(@user)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by!(number: params[:token])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name)
    end
  end
end
