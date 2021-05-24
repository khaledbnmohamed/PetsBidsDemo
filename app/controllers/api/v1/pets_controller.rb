# frozen_string_literal: true

module Api::V1
  class PetsController < ::Api::BaseController
    before_action :set_user, :set_chat, except: :reindex

    before_action :set_pet, only: %i[show edit update destroy]

    # GET /pets
    def index
      pets = @user.pets

      render json: { pets: PetBlueprint.render_as_json(render_option) }
    end

    # GET /pets/1
    def show; end

    # GET /pets/1/edit
    def edit; end


    # PATCH/PUT /pets/1
    def update
      raise Errors::CustomError.new(:bad_request, 400, @pet.errors.pets) unless @pet.update(pet_params)

      render json: PetBlueprint.render(@pet)
    end

    # DELETE /pets/1
    def destroy
      @pet.destroy
      render json: PetBlueprint.render(@pet)
    end


    private

    def set_user
      @user = User.find_by!(id: params[:user_id])
    end

  end
end
