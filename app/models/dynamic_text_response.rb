class DynamicTextResponse < ActiveRecord::Base
  attr_accessible :dynamic_text_id, :text
  belongs_to :dynamic_text
end
