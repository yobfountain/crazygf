class DynamicConversation < ActiveRecord::Base
  attr_accessible :dynamic_text_response_id, :user_id
  belongs_to :user
  belongs_to :dynamic_text_response
end
