class Note < ActiveRecord::Base
  acts_as_taggable
  validates :name, presence: true
  validates :content, presence: true
end
