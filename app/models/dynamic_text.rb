class DynamicText < ActiveRecord::Base
  attr_accessible :category_id, :description, :keywords, :name, :score, :image_url
  belongs_to :category
  has_many :dynamic_text_responses
  
end
