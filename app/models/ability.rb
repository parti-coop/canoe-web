class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :create, [Canoe, BoardingRequest]
  end
end
