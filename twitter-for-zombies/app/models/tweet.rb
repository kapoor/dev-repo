class Tweet < ActiveRecord::Base
  attr_accessible :status, :zombie
  
  validates_presence_of :status
  
  belongs_to :zombie
end
