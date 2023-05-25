class AddressController < ApplicationController
  def new
    @address = Address.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      current_user.update(address: @address)
      redirect_to checkout_create_path
    else
      respond_to do |format|
        format.js { render 'new' }
      end
    end
  end
  

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :postal_code, :country)
  end
end
