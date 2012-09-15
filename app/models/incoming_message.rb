class IncomingMessage < ActiveRecord::Base
  attr_accessible :content, :response_id, :response_type, :reviewed, :user_id
  belongs_to :user
  belongs_to :response, :polymorphic => true
  
  
  def self.texts
   where(:response_type => 'Text', :include => :response)
  end
  
  def self.dynamic_text_responses
    where(:response_type => 'DynamicTextResponse', :include => :response)
  end
  
  module ProxyMethods
  end
  
end
