class Voicemail < ActiveRecord::Base
  attr_accessible :approved, :duration, :featured, :url, :user_id
  before_create :init_values
  
  belongs_to :user
  
  private 
  
  def init_values
    self.featured = false
    self.approved = false
  end
  
end
