class User < ActiveRecord::Base
  attr_accessible :name, :phone_number, :score, :enabled
  before_create :init_score
  has_many :conversations

  has_many :dynamic_conversations
  has_many :user_games


  def conversation_list
    conversations.map(&:text_id)
  end
  
  def dynamic_conversation_list
    dynamic_conversations.map(&:dynamic_text_response_id)
  end 
  
  def self.active_users
    find :all, :conditions => ['enabled = ?', true]
  end
  
  private
  
  def init_score
    self.score = 0
  end
     
end
