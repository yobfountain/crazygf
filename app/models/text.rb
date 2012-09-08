class Text < ActiveRecord::Base
  attr_accessible :category_id, :score, :text, :image_url
  attr_accessible :picture
  belongs_to :category
  
  has_attached_file :picture,
      :storage => :s3,
      :s3_credentials => S3_CREDENTIALS,
      :bucket => "crazygf"
end
