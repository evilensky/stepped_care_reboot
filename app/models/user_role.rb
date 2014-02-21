class UserRole < ActiveRecord::Base
  ROLES = [
    'Roles::Clinician',
    'Roles::Researcher',
    'Roles::ContentAuthor'
  ]

  belongs_to :user

  validates :user, presence: true
  validates :role_class_name, inclusion: { in: ROLES }

  def role
    role_class_name.constantize.new
  end
end
