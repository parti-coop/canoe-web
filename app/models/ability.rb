class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :create, [Canoe, SailingDiary, BoardingRequest]
    can :update, [Canoe, SailingDiary, BoardingRequest]
    can :destroy, [Canoe, SailingDiary, BoardingRequest]
  end
end
