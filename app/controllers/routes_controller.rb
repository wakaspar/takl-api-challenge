class RoutesController < ApplicationController

  # GET /routes
  def index
    @routes = Route.all
    render json: @routes
  end

  # GET /routes/:id
  def show
    render json: @route
  end

  # POST /routes
  def create
    @route = Route.new(route_params)
    if @route.save
      render json: @route, status: :created, location: @route
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /routes/:id
  def update
    @route = Route.update(route_params)
    if @route.save
      render json: @route, status: :created, location: @route
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

# DELETE /routes/:id
  def destroy
    @route.destroy
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit( :provider,
                                   :response,
                                   addresses_attributes: [:street_address, :city, :state, :zip],
                                   :geo_coordinates => [] )
  end

end
