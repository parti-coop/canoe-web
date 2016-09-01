class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can :create, [Canoe, SailingDiary, BoardingRequest, Discussion, Opinion]

      can [:destroy, :update], [Canoe, SailingDiary, Discussion, Opinion] do |model|
        user == model.user
      end

      can :destroy, BoardingRequest do |br|
        user == model.user
      end
      can :accept, BoardingRequest do |br|
        br.canoe.member? user
      end
    end
  end
end
