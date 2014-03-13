class ThoughtPattern < ActiveRecord::Base
  validates :title, :description, presence: true
end
