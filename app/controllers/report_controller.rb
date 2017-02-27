class ReportController < ApplicationController
  before_action :authenticate_admin!
  def index
  end

  def order_report
  	@orders_successful = Order.where(status: 'successfull').group_by { |t| t.created_at.strftime("%B/%Y") }
  	@orders_cancelled = Order.where(status: 'cancelled').group_by { |t| t.created_at.strftime("%B/%Y") }
  	@months = @orders_successful.keys
  	@orders_count_success = []
    @orders_successful.each do |key, value|
       @orders_count_success << value.size
    end

    @orders_count_cancel = []
    @orders_cancelled.each do |key, value|
      @orders_count_cancel << value.size
    end

  end

  def coupon_report
  	 @used_coupons = UsedCoupon.all.group_by { |t| t.created_at.strftime("%B/%Y")}
  	 @coupon_months = @used_coupons.keys
  	 @used_coupons_count = []
  	 @used_coupons.each do |key, value|
  	 	@used_coupons_count << value.size
  	 end
  end 

  def user_report
  	@users = User.all.group_by { |t| t.created_at.strftime("%B/%Y")}
  	@months_user = @users.keys
  	@users_count = []
  	@users.each do |key, value|
  		@users_count << value.size
  	end
  end
end
