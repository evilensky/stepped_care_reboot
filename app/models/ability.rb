# Uses CanCan to assign granular authorizations.
class Ability
  include CanCan::Ability

  def initialize(user)
  end
end
