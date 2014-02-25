class ContentProvider < ActiveRecord::Base
  belongs_to :content_module
  belongs_to :source_content, polymorphic: true, inverse_of: :content_provider

  validates :content_module, :position, presence: true
  validates_numericality_of :position, greater_than_or_equal_to: 1

  delegate :context, to: :content_module, prefix: false

  # def data_attributes
  	#alert of some sort that says you are calling ContentProvider data_attributes
  # end

end
