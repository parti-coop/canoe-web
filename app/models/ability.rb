class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, :all
      can :create, [Canoe, SailingDiary, BoardingRequest, Discussion]
      can :update, [Canoe, SailingDiary, BoardingRequest, Discussion]
      can :destroy, [Canoe, SailingDiary, BoardingRequest, Discussion]
    end
  end
end
