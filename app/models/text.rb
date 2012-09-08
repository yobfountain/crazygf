class Text < ActiveRecord::Base
  attr_accessible :category_id, :score, :text, :image_url
  attr_accessible :picture

  belongs_to :category
  
  attr_accessible :emotion_list, :tag_list, :topic_list

  acts_as_taggable
  acts_as_taggable_on :emotions, :tags, :topics
  
  has_attached_file :picture,
      :storage => :s3,
      :s3_credentials => S3_CREDENTIALS,
      :bucket => "crazygf"
end
