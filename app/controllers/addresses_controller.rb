class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]

  def create
    @address = current_user.addresses.new(address_params)
    respond_to do |format|
      if @address.save
        format.html { redirect_to check_outs_path, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
        format.js
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    @address = Address.find(params[:id])
    if params[:status] == "delete"
      @address.update(status: 'inactive')
      @address.save
      redirect_to check_outs_path, notice: 'Address was successfully deleted' 
    else
      respond_to do |format|
        if @address.update(address_params)
          format.html { redirect_to check_outs_path, notice: 'Address was successfully updated.' }
          format.json { render :show, status: :ok, location: @address }
        else
          format.html { render :edit }
          format.json { render json: @address.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to check_outs_path, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_address
      @address = current_user.addresses.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:status, :email, :first_name, :last_name, :address1, :address2,:postal_code, :country, :state, :mobile_no)
    end
end
