class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can :create, [Canoe, BoardingRequest]
      can :create, [SailingDiary, Discussion, Opinion, ProposalRequest, Proposal, Vote] do |model|
        model.canoe.member? user
      end

      can [:destroy, :update], [Canoe, SailingDiary, Discussion, Opinion, ProposalRequest, Proposal] do |model|
        user == model.user
      end

      can [:consensus, :edit_consensus], Discussion do |model|
        model.canoe.member? user
      end

      can :destroy, BoardingRequest do |br|
        user == br.user
      end
      can :accept, BoardingRequest do |br|
        br.canoe.member? user
      end

      can [:agree, :block, :vote], Proposal do |proposal|
        proposal.canoe.member?(user)
      end
    end
  end
end
