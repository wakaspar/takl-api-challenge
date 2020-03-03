class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :update, :destroy]

  # GET /routes
  def index
    @routes = Route.all
    render json: @routes
  end

  # GET /routes/:id
  def show
    p "GET by :id = " + params[:id]
    render json: @route
  end

  # POST /routes
  def create

    get_optimal_route

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

  def get_optimal_route
    p "INSIDE GET_OPTIMAL_ROUTE"
    # get coordinates for a Route's addresses
    get_geo_coords

    p @geo_array
  end

  def get_geo_coords
    # addresses from request params
    @address_array = params[:route][:addresses_attributes]
    # uses Geocoder to map addresses to coordinates
    @geo_array = @address_array.map { |address|
      full_address = address.values.join(', ')
      geo_coords = Geocoder.search(full_address)
      geo_coords = geo_coords.first.coordinates
     }
     # return array of coordinates
    return @geo_array
  end

  def route_params
    params.require(:route).permit( :provider,
                                   :response,
                                   addresses_attributes: [:street_address, :city, :state, :zip],
                                   :geo_coordinates => [] )
  end

end
