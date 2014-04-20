class NoteTag < ActiveRecord::Base
  belongs_to :user
  has_many :note_taggings, :dependent => :destroy
  has_many :notes , through: :note_taggings

  validates :name, :uniqueness => {:scope => :user_id}

  def self.create_from_string(user, string)

    return [] unless string

    tags = string.split(",").map(&:strip)
    tags.map do |tag|
      NoteTag.where(user:user, name:tag).first_or_create
    end

  end

end
