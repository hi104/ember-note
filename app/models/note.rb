class Note < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :note_taggings, :dependent => :destroy
  has_many :note_tags , through: :note_taggings

  attr_accessor :tag_list #for create note_taggings by controller params

  def tag_list_string
    note_tags.map(&:name).join(', ')
  end

end
