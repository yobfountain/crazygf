class User < ActiveRecord::Base
  attr_accessible :name, :phone_number, :score
  before_create :init_score

  private
  
  def init_score
    self.score = 0
  end
      
end
