class PayRequestsController < ApplicationController
  before_action :authenticate_user!

  def show
    @pay_request = PayRequest.find_by id: params[:id]
    @res = params[:res].split("|")
  end

  def new
    @pay_request = current_user.pay_requests.new
  end

  def create
    @pay_request = current_user.pay_requests.new pay_request_params
    if @pay_request.save
      uri = URI("https://www.nganluong.vn/mobile_card.api.post.v2.php")
      @res = Net::HTTP.post_form(uri,
                                 func:              @pay_request.func,
                                 version:           @pay_request.version,
                                 merchant_id:       @pay_request.merchant_id,
                                 merchant_account:  @pay_request.merchant_account,
                                 merchant_password: @pay_request.merchant_password,
                                 pin_card:          @pay_request.pin_card,
                                 card_serial:       @pay_request.serial_card,
                                 type_card:         @pay_request.type_card,
                                 ref_code:          @pay_request.ref_code,
                                 client_fullname:   @pay_request.client_fullname,
                                 client_email:      @pay_request.client_email,
                                 client_mobile:     @pay_request.client_mobile)
      redirect_to pay_request_path(@pay_request, res: @res.body)
    else
      render :new
    end
  end

  private
  def pay_request_params
    params.require(:pay_request).permit :serial_card, :pin_card, :type_card
  end
end
