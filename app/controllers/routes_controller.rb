class RoutesController < ApplicationController
  include HTTParty
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
    # save response in db w/ POST request
    @route.response = @res.parsed_response

    if @route.save
      # properly format route before returning to user
      generate_user_response
      # output
      # p '<== USER_RESPONSE ==>'
      # p @user_response

      render json: @user_response, status: :created, location: @route

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


  # Sets Route on show, update, and destroy
  def set_route
    @route = Route.find(params[:id])
  end

  # GET optimal delivery route from HERE API
  def get_optimal_route

    # prepare starting [x,y] for API request
    prep_start_point
    # prepare destinations for API request
    prep_destinations
    # combines start_point and destinations into a query string
    build_query_string
    # sends formatted GET Request to Traveling Salesman Endpoint of HERE API
    @res = HTTParty.get(@query_string, format: :plain)

    return @res
  end

  # Generates properly formatted user response for POST method
  def generate_user_response
    # once saved, parse JSON response
    @res = JSON.parse @res, symbolize_names: true
    @res = @res[:results][0][:waypoints]

    @user_response = Array.new

    @res.map.with_index { |wp|
      waypoint = Hash.new
      address = Geocoder.search([ wp[:lat], wp[:lng] ])

      waypoint[:address] = address.first.address
      waypoint[:longitude] = wp[:lat]
      waypoint[:latitude] = wp[:lng]
      p waypoint

      @user_response.push(waypoint)
    }

    return @user_response
  end

  # Prepare destinations, use Geocoder to get [x,y] for a route's addresses
  def prep_destinations
    # grabs addresses from request params
    @delivery_route_addresses = params[:route][:addresses_attributes]
    # map delivery addresses into [x,y]
    @destinations = @delivery_route_addresses.map.with_index(1) { |address, idx|
      # concat address vales into continuous string
      address = address.values.join(', ')
      # use Geocoder to get lat, lon coordiantes
      coords = Geocoder.search(address).first.coordinates
      # clean results and convert to strings
      coords = coords.reject(&:blank?).join(',')
      # properly format destinations for API request
      coords = 'destination' + idx.to_s + '=' + coords
     }
    return @destinations
  end

  # Prepare starting geo coordiantes
  def prep_start_point
    # convert geo_coordinates to strings
    @start_point = params[:route][:geo_coordinates]
    # properly format geo_coordinates for API request
    @start_point = 'start=' + @start_point.join(',').to_s + '&'

    return @start_point
  end

  # Build query string for API request
  def build_query_string
    # base URI for request
    @base_uri = 'https://wse.ls.hereapi.com/2/findsequence.json?'
    # application-based HERE API key
    @apiKey = '2EQNCCaqaxKw01dy0uXu2HVo_HeAP8xBIxghL1yNM5A'
    # builds query string for HERE API's optimal route endpoint
    @query_string = @base_uri + @start_point + @destinations.join('&') + '&mode=fastest;car&' + 'apiKey=' + @apiKey

    return @query_string
  end

  # Requires and permits Route parameters
  def route_params
    params.require(:route).permit( :provider,
                                   :response,
                                   addresses_attributes: [:street_address, :city, :state, :zip],
                                   :geo_coordinates => [] )
  end

end
