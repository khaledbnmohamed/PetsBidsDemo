module Api::V1
  class BidsController < ::Api::BaseController
    before_action :set_pet

    before_action :set_bid, only: %i[show edit update destroy]

    # GET /bids
    def index
      bids = @pet.bids
      render json: BidBlueprint.render_as_json(bids)
    end

    # GET /bids/1
    def show
      render json: BidBlueprint.render(@bid)
    end

    # GET /bids/1/edit
    def edit; end

    # POST /bids
    def create
      # the user part should be generic based on the credentials of the logged in not as a param
      bid_details = bid_params.merge(pet_id: @pet.id)
      bid = Bid.new(bid_details)

      raise Errors::CustomError.new(:bad_request, 400, bid.errors.messages) unless bid.save

      render json: BidBlueprint.render(bid)
    end

    # PATCH/PUT /bids/1
    def update
      raise Errors::CustomError.new(:bad_request, 400, @bid.errors.messages) unless @bid.update(bid_params)

      render json: BidBlueprint.render(@bid)
    end

    # DELETE /bids/1
    def destroy
      raise Errors::CustomError.new(:bad_request, 400, @bid.errors.messages) unless @bid.destroy

      render json: BidBlueprint.render(@bid)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find_by!(id: params[:pet_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = @pet.bids.find_by!(number: params[:id])
    end
    

    # Only allow a trusted parameter "white list" through.
    def bid_params
      params.require(:bid).permit(:bid_price, :user_id)
    end
  end
end
