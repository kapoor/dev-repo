class Topic < ActiveRecord::Base
  belongs_to :user
  attr_accessible :posted_on, :poster_id, :title
  validates :title,  :presence => true, :length => { :minimum => 5 } 
  has_many :posts, :dependent => :destroy
end
