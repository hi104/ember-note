class Note < ActiveRecord::Base
  acts_as_taggable
  validates :name, presence: true
  validates :content, presence: true

  def tag_list_string
    taggings.map do |e|
      e.tag.name
    end.join(', ')
  end

end
