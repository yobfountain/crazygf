desc "This task is called by the Heroku scheduler add-on"
task :send_texts => :environment do
    puts "Sending messages..."
    @users = User.all
    @users.each do |user|
      text = Text.get_text_for_user(user)
      if text
        conversation = Conversation.create(:text_id => text.id, :user_id => user.id)
      else
        text = Text.get_text_randomly
      end
      
      twilio_client = Twilio::REST::Client.new CRAZYGF_TWILIO_ACCOUNT_SID, CRAZYGF_TWILIO_SECRET
      twilio_client.account.sms.messages.create(
        :from => "+1#{CRAZYGF_TWILIO_MOBILE_NUMBER}",
        :to => user.phone_number,
        :body => text.text
      )
    end
    puts "done."
end