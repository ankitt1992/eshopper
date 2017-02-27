class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update]

  def create
    @address = current_user.addresses.new(address_params)
    respond_to do |format|
      if @address.save
        format.html { redirect_to check_outs_path, notice: 'Address was successfully created.' }
        format.js
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to check_outs_path, notice: 'Address was successfully updated.' }
        format.js
      else
        format.js
      end
    end
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:status, :email, :first_name, :last_name, :address1, :address2,:postal_code, :country, :state, :mobile_no)
    end
    
end
