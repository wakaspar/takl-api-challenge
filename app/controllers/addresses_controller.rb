class AddressesController < ApplicationController
  before_action :set_address, only: [:create, :show, :update, :destroy]

  # GET /addresses
  def index
    @addresses = Address.all
    render json: @addresses
  end

  # GET /addresses/:id
  def show
    render json: @address
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)
    if @address.save
      render json: @address, status: :created, location: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /addresses/:id
  def update
    @address = Address.update(address_params)
    if @address.save
      render json: @address, status: :created, location: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

# DELETE /addresses/:id
  def destroy
    @address.destroy
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit( :street_address,
                                     :city,
                                     :state,
                                     :zip,
                                     :route )
  end

end
