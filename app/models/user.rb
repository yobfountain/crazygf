class User < ActiveRecord::Base
  attr_accessible :name, :phone_number, :score
end
