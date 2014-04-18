class Note < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  has_many :note_taggings, :dependent => :destroy
  has_many :note_tags , through: :note_taggings

  def tag_list_string
    note_tags.map(&:name).join(', ')
  end

end
