class Post < ActiveRecord::Base
  belongs_to :topic
  attr_accessible :posted_on, :poster_id, :text
  validates :text,  :presence => true, :length => { :minimum => 10 }
end
