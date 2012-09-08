class ApiController < ApplicationController
  
  protect_from_forgery :except => :receive_text 
  
  def receive_text 
    message_body = params["Body"]
    from_number = params["From"]
    @user = User.find_or_create_by_phone_number(from_number)
    if @user and message_body == "register"
      @twilio_client = Twilio::REST::Client.new CRAZYGF_TWILIO_ACCOUNT_SID, CRAZYGF_TWILIO_SECRET
      @twilio_client.account.sms.messages.create(
        :from => "+1#{CRAZYGF_TWILIO_MOBILE_NUMBER}",
        :to => @user.phone_number,
        :body => "Hello baby! I miss you"
      )
      render :text => 'User registered'
    else
      #do logic
      @text = Text.first
      @twilio_client = Twilio::REST::Client.new CRAZYGF_TWILIO_ACCOUNT_SID, CRAZYGF_TWILIO_SECRET
      @twilio_client.account.sms.messages.create(
        :from => "+1#{CRAZYGF_TWILIO_MOBILE_NUMBER}",
        :to => @user.phone_number,
        :body => @text.text
      )
      render :text => 'Ok'
    end
  end
  
  
  def send_text_message
      number_to_send_to = params[:number_to_send_to]

      twilio_sid = "abc123"
      twilio_token = "foobar"
      twilio_phone_number = "6165555555"

      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

      @twilio_client.account.sms.messages.create(
        :from => "+1#{CRAZYGF_TWILIO_MOBILE_NUMBER}",
        :to => number_to_send_to,
        :body => "This is an message. It gets sent to #{number_to_send_to}"
      )
    end
  
end