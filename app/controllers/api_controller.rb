class ApiController < ApplicationController
  protect_from_forgery :except => :receive_text 
  skip_before_filter :verify_authenticity_token   
  
  UNSUB_KEYWORDS = ['unsub', 'unsubscribe', 'quit', 'stop', 'Stop', 'Quit', 'Unsubscribe', 'Unsub', 'Unsubscribe.', 'Unsub.', 'Stop.', 'Quit.']
  
  def receive_text    
    message_body = params["Body"]
    from_number = params["From"]

    @user = User.find_or_create_by_phone_number(from_number)
    @dynamic_text = DynamicText.search(message_body)
    @new_user = true if @user.conversations.size == 0
    @first_reply = true if @user.conversations.size == 1
 
    @incoming_message = IncomingMessage.create(:user_id => @user.id, :content => message_body)
    @unsubscribe = check_for_unsubscribe(message_body)


    #case 1 - User is unsubscribe
    if @user and @unsubscribe
      #unsubscribe user
      @user.disable_user
      @text = "Adios"
    
    #case 2 - User is first_reply
    if @user and @first_reply
      @user.name == message_body
      @user.save
      @get_text = Text.get_text_for_user(@user)
      @text = @get_text.text if @get_text
      
    #case 3 - @dynamic_text exists 
    elsif @user and @dynamic_text
      @get_text = @dynamic_text.dynamic_text_responses.find :first, :order => 'RANDOM()'
      @text = @get_text.text

    #case 4 - get_text_for_user
    elsif @user
      @get_text = Text.get_text_for_user(@user)
      @text = @get_text.text if @get_text
      #case 5 - get_text_randomly
      if @text == nil
        @get_text = Text.get_text_randomly
        @text = @get_text.text
      end
    end 
    
    if @get_text and @user
      @user.enabled_user
      if @incoming_message
        @incoming_message.response = @get_text
        @incoming_message.save
      end
      if @dynamic_text
        @conversation = DynamicConversation.create(:dynamic_text_response_id => @get_text.id, :user_id => @user.id)
      else
        @conversation = Conversation.create(:text_id => @get_text.id, :user_id => @user.id)
      end
    end

    if @text and @user
      @twilio_client = Twilio::REST::Client.new CRAZYGF_TWILIO_ACCOUNT_SID, CRAZYGF_TWILIO_SECRET
      @twilio_client.account.sms.messages.create(
        :from => "+1#{CRAZYGF_TWILIO_MOBILE_NUMBER}",
        :to => @user.phone_number,
        :body => @text
      )
      @xml_response = "Ok"
    else
      @xml_response = "failure"
    end
    render 'receive_text.xml.erb', :content_type => 'text/xml'
  end
  
  #not currently used
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
    
    def check_for_unsubscribe(body)
      unsubscribe = false
      UNSUB_KEYWORDS.each do |kw|
        if body == kw
           unsubscribe = true
        end
      end
      return unsubscribe
    end
    
    def receive_call    
      from_number = params["From"]
      @user = User.find_or_initialize_by_phone_number(from_number)
      if @user.new_record?
        @user.save
        # new user calling, don't record message
        # ogm_sms plays the ogm then redirects to 'api/twilio/sms'
        render 'ogm_sms.xml'
        # TODO: add send follow up text        
      else
        # known user, record voicemail
        render 'ogm_record.xml'
    end
    
    # called from 'ogm_record.xml'
    # '/api/twilio/record'
    def record_call
      from_number = params["From"]
      voicemail_url = params["RecordingUrl"]
      voicemail_duration = params["RecordingDuration"]
      
      voicemail = Voicemail.new
      voicemail.user_id = User.find_or_create_by_phone_number(from_number)
      voicemail.url = voicemail_url
      voicemail.duration = voicemail_duration
      voicemail.save
      
    end
  
end