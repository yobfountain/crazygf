class DynamicText < ActiveRecord::Base
  attr_accessible :category_id, :description, :keywords, :name, :score, :image_url
  belongs_to :category
  has_many :dynamic_text_responses
  
  def self.search(search)
    if search
      search_length = search.split.length
      find(:first, :conditions => [(['keywords LIKE ?'] * search_length).join(' OR ')] + search.split.map { |name| "%#{name}%" },:order => 'RANDOM()')
    else
      nil
    end
  end
end
