class Conversation < ActiveRecord::Base
  attr_accessible :text_id, :user_id
  belongs_to :user
end
