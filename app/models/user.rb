class User < ActiveRecord::Base
  attr_accessible :name, :phone_number, :score
  before_create :init_score
  has_many :conversations
  has_many :dynamic_conversations

  def conversation_list
    conversations.map(&:text_id)
  end
  
  def dynamic_conversation_list
    dynamic_conversations.map(&:dynamic_text_response_id)
  end 
  
  private
  
  def init_score
    self.score = 0
  end
     
end
