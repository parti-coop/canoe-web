class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Canoe
    if user
      can :create, [Canoe, BoardingRequest]
      can [:read, :create], [Category, SailingDiary, Discussion, Opinion, Comment, ProposalRequest, Proposal, Vote, ConsensusRevision] do |model|
        model.canoe.member? user
      end

      can [:read, :update, :member], Canoe do |model|
        model.member? user
      end

      can [:destroy, :update], Category do |model|
        model.canoe.member? user
      end

      can [:destroy, :update, :inbox, :archive], [SailingDiary, Discussion, Opinion, Comment, ProposalRequest, Proposal] do |model|
        user == model.user
      end

      can [:cancel, :read], Membership do |membership|
        user == membership.user
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

      can [:agree, :block, :vote, :unvote], Proposal do |proposal|
        proposal.canoe.member?(user)
      end
    end
  end
end
