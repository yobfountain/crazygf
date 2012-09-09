class UserGame < ActiveRecord::Base
  attr_accessible :chances, :game_id, :result, :state, :user_id
  belongs_to :user
  belongs_to :game
end
