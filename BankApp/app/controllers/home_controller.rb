class HomeController < ApplicationController
  before_filter :authenticate_user!, only: %w(pay proccess)
  before_filter :extract_totp, only: %w(pay proccess)
  skip_before_action :verify_authenticity_token

  def index
  end

  def pay
    if current_user.expiry < Date.today
        trans = Transaction.new
        trans.user_id = current_user.id
        trans.success = false;
        trans.note = "Credit Card expired"
        trans.amount = params['amount']
        trans.save
        redirect_to "http://localhost:3000/failed?reason=credit%20card%20expired"
    else
        @totp_now = @totp.now
    end
  end

  def proccess
    if @totp.verify(params['my_token'])
        trans = Transaction.new
        trans.user_id = current_user.id
        trans.success = true;
        trans.note = ""
        trans.amount = params['amount']
        trans.save
        redirect_to "http://localhost:3000/success_pay?my_token="+params['prev_token']
    else
        redirect_to "http://localhost:4000/pay?my_token="+params['prev_token']+"&amount="+params['prev_amount'],
            flash: {warning: "Oops, TOTP code did not match"}
    end
  end

  private
  def extract_totp
    @totp = ROTP::TOTP.new("base32secretkey3232")
  end
end
