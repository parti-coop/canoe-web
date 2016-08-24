class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, :all
      can :create, [Canoe, SailingDiary, BoardingRequest, Discussion, Opinion]
      can :update, [Canoe, SailingDiary, BoardingRequest, Discussion, Opinion]
      can :destroy, [Canoe, SailingDiary, BoardingRequest, Discussion, Opinion]
    end
  end
end
