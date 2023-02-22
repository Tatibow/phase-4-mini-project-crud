class SpicesController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :render_response_error

    def index
        spices = Spice.all
        render json: spices, status: :ok
    end


    def create
        newSpice = Spice.create(spice_params)
        render json: newSpice, status: :created
    end

    def update
        spice = find_spice
            spice.update(spice_params)
            render json: spice, status: :ok
            # rescue ActiveRecord::RecordNotFound
            # render_response_error
    end

  def destroy
    spice = find_spice
        spice.destroy
        head :no_content
        # rescue ActiveRecord::RecordNotFound
        # render_response_error
  end


    # private area
    private

    def find_spice
        Spice.find(params[:id])
    end

    def render_response_error
        render json: {error: "spice not found"}, status: :not_found
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
end
