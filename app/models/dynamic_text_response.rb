class DynamicTextResponse < ActiveRecord::Base
  attr_accessible :dynamic_text_id, :text
  belongs_to :dynamic_text
  
  require_dependency "incoming_message"
  
  has_many :incoming_messages, :as => :response do
    include IncomingMessage::ProxyMethods
  end
  
  
  def self.get_response_for_user(user)
    if user.dynamic_conversations.size == 0
      self.find(:first, :order => "RANDOM()")
    else
      self.find(:first, :conditions => ["id NOT IN (?)", user.dynamic_conversation_list], :order => 'RANDOM()')
    end
  end
  
end
