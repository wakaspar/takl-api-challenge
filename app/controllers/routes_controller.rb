class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :update, :destroy]

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
    # get delivery Route from HERE API
    get_optimal_route
    # create new Route in db
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


  # sets Route on show, update, and destroy
  def set_route
    @route = Route.find(params[:id])
  end

  # GET optimal delivery route
  def get_optimal_route
    # base URI for request to HERE API
    @base_uri = 'https://wse.ls.hereapi.com/2/findsequence.json?'
    # returns @delivery_route_coordinates, an array of coordinates from addresses POSTed
    get_geo_coords
    # converts array of coordinates into strings, renamed as destinations
    @destinations = @delivery_route_coordinates.map { |coords|
      coords.reject(&:blank?).join(',')
    }
    # prepares starting coordinates for HERE API request
    @start_point = params[:route][:geo_coordinates]
    @start_point = @start_point.map { |coord|
      coord.to_s
    }
    @start_point = 'start=' + @start_point[0] + ',' + @start_point[1] + '&'

    # prepares destinations for HERE API request
    @destinations = @destinations.map.with_index(1) do |dest, idx|
      dest = 'destination' + idx.to_s + '=' + dest + '&'
    end

    # SANITY CHECK OUTPUT BEFORE HTTPARTY REQUEST
    p '<== STARTING POINT ==>'
    p @start_point
    p '<== DELIVERY ROUTE ==>'
    p @destinations


    # @res = HTTParty.get('')
    # puts @res.body

  end

  # Uses Geocoder to get coordinates for a deliery route's addresses
  def get_geo_coords
    # grabs addresses from request params
    @delivery_route_addresses = params[:route][:addresses_attributes]
    # uses Geocoder to map delivery addresses to coordinates
    @delivery_route_coordinates = @delivery_route_addresses.map { |address|
      address = address.values.join(', ')
      address = Geocoder.search(address)
      address = address.first.coordinates
     }
    # returns array of delivery coordinates
    return @delivery_route_coordinates
  end

  # requires and permits Route parameters
  def route_params
    params.require(:route).permit( :provider,
                                   :response,
                                   addresses_attributes: [:street_address, :city, :state, :zip],
                                   :geo_coordinates => [] )
  end

end
