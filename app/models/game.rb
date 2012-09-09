class Game < ActiveRecord::Base
  attr_accessible :chances, :default_response, :description
  attr_accessible :failure_response, :name, :score, :success_response, :text
  
end
