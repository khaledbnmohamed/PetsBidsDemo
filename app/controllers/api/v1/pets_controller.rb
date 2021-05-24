# frozen_string_literal: true

module Api::V1
  class PetsController < ::Api::BaseController
    before_action :set_application, :set_chat, except: :reindex

    before_action :set_pet, only: %i[show edit update destroy]

    # GET /pets
    def index
      pets = if params[:keyword].present?
                   @chat.pets.search(params[:keyword])
                 else
                   @chat.pets
                 end

      render_option = params[:keyword].present? ? elastic_search_result(pets) : pets
      render json: { pets: PetBlueprint.render_as_json(render_option) }
    end

    # GET /pets/1
    def show; end

    # GET /pets/1/edit
    def edit; end

    # POST /pets
    def create
      begin
        creation_response = PetCreationService.create_pet(@chat, pet_params[:text])
      rescue ActiveRecord::StaleObjectError => e
        Rails.logger.info '============= Pet Version Error =============== '
        Rails.logger.info e
        Rails.logger.info '============= Pet Version Error =============== '
        creation_response = PetCreationService.create_pet(@chat, pet_params[:text])
      end

      render json: creation_response
    end

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

    def set_application
      @application = Application.find_by!(number: params[:application_token])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = @application.chats.find_by!(number: params[:chat_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = @chat.pets.find_by!(number: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pet_params
      params.require(:pet).permit(:text)
    end

    def elastic_search_result(pets)
      hits = []
      if pets.present?
        pets.each do |m|
          hits << m['_source']
        end
      end
      hits
    end
  end
end
