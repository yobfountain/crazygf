class Voicemail < ActiveRecord::Base
  attr_accessible :approved, :duration, :featured, :url, :user_id
  before_create :initialize
  
  belongs_to :user
  
  def initialize
    self.featured = false
    self.approved = false
  end
  
end
