class DynamicText < ActiveRecord::Base
  attr_accessible :category_id, :description, :keywords, :name, :score, :image_url
  belongs_to :category
end
