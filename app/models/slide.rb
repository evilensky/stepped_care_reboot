class Slide < ActiveRecord::Base
  belongs_to :slideshow, inverse_of: :slides

  validates :title, :body, :position, presence: true
  validates_numericality_of :position, greater_than_or_equal_to: 1
  validates_uniqueness_of :position, scope: :slideshow_id

  def render_body
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :space_after_headers => true)

    markdown.render(body).html_safe
  end
end
