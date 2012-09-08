class Text < ActiveRecord::Base
  attr_accessible :category_id, :score, :text, :image_url
  attr_accessible :picture
  
  has_attached_file :picture,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :bucket => "crazygf"
end
