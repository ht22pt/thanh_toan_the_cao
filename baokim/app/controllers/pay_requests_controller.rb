class PayRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pay_request = current_user.pay_requests.new
  end

  def create
    @pay_request = current_user.pay_requests.new pay_request_params
    if @pay_request.save
      uri = URI('https://www.baokim.vn/the-cao/restFul/send/')
      @res = Net::HTTP.post_form(uri,
                                 merchant_id:    @pay_request.merchant_id,
                                 api_username:   @pay_request.api_username,
                                 api_password:   @pay_request.api_password,
                                 transaction_id: @pay_request.transaction_id,
                                 card_id:        @pay_request.card_id,
                                 pin_field:      @pay_request.pin_field,
                                 seri_field:     @pay_request.seri_field,
                                 algo_mode:      @pay_request.algo_mode,
                                 data_sign:      @pay_request.data_sign)
      redirect_to pay_request_path(@pay_request, res: @res.body)
    else
      render :new
    end
  end

  def show
    @pay_request = PayRequest.find_by id: params[:id]
    @res = JSON.parse params[:res] if params[:res]
  end

  private
  def pay_request_params
    params.require(:pay_request).permit :card_id, :pin_field, :seri_field
  end
end
