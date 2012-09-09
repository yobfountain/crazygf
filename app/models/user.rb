class User < ActiveRecord::Base
  attr_accessible :name, :phone_number, :score, :enabled
  before_create :init_score
  has_many :conversations
  has_many :user_games

  def converstion_list
    conversations.map(&:text_id)
  end 
  
  def self.active_users
    find :all, :conditions => ['enabled = ?', 1]
  end
  
  private
  
  def init_score
    self.score = 0
  end
     
end
