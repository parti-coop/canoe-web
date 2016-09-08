module SlackPushing
  extend ActiveSupport::Concern

  def push_to_slack(subject)
    return if ApplicationController::skip_slack
    return unless user_signed_in?

    @webhook_url = fetch_webhook_url(subject)
    return if @webhook_url.blank?
    notifier = Slack::Notifier.new(@webhook_url, username: 'parti-canoe')

    message = make_message(subject)
    if message.present?
      notifier.ping("[[#{@canoe.title} 카누](#{view_context.canoe_url @canoe})] #{message[:title]}", attachments: [{ text: message[:body], color: "#36a64f" }])
    end
  end

  private

  def fetch_webhook_url(subject)
    @canoe = subject if subject.is_a? Canoe
    @canoe ||= subject.try(:canoe)
    @canoe ||= subject.try(:discussion).try(:canoe)
    @canoe.try(:slack_webhook_url)
  end

  def make_message(subject)
    title = ""
    body = ""

    case "#{controller_name}##{action_name}"
    when "canoes#update"
      canoe = subject
      title = "@#{current_user.nickname}님이 카누 설정을 고쳤습니다."
    when "discussions#create"
      discussion = subject
      title = "@#{current_user.nickname}님이 논의를 만들었습니다."
      body = body_with_discussion(discussion)
    when "discussions#update"
      discussion = subject
      title = "@#{current_user.nickname}님이 논의를 고쳤습니다."
      body = body_with_discussion(discussion)
    when "discussions#destroy"
      discussion = subject
      title = "@#{current_user.nickname}님이 논의를 지웠습니다."
      body = body_with_discussion(discussion)
    when "discussions#consensus"
      discussion = subject
      title = "@#{current_user.nickname}님이 합의사항을 만집니다."
      body = body_with_discussion(discussion, "#{view_context.truncate discussion.consensus, length: 100}")
    when "proposal_requests#create"
      proposal_request = subject
      discussion = proposal_request.discussion
      title = "@#{current_user.nickname}님이 제안을 요청합니다."
      body = body_with_discussion(discussion, proposal_request.title)
    when "proposals#create"
      proposal = subject
      title = "@#{current_user.nickname}님이 제안을 만들었습니다."
      body = body_with_proposal_request(proposal.proposal_request, proposal.title)
    when "proposals#update"
      proposal = subject
      title = "@#{current_user.nickname}님이 제안을 고쳤습니다."
      body = body_with_proposal_request(proposal.proposal_request, proposal.title)
    when "proposals#destroy"
      proposal = subject
      title = "@#{current_user.nickname}님이 제안을 지웠습니다."
      body = body_with_proposal_request(proposal.proposal_request, proposal.title)
    when "opinions#create"
      opinion = subject
      discussion = opinion.discussion
      title = "@#{current_user.nickname}님이 의견을 올렸습니다."
      body = body_with_discussion(discussion, opinion.body)
    when "opinions#update"
      opinion = subject
      discussion = opinion.discussion
      title = "@#{current_user.nickname}님이 의견을 고쳤습니다."
      body = body_with_discussion(discussion, opinion.body)
    when "opinions#destroy"
      opinion = subject
      discussion = opinion.discussion
      title = "@#{current_user.nickname}님이 의견을 지웠습니다."
      body = body_with_discussion(discussion, opinion.body)
    when "comments#create"
      comment = subject
      title = "@#{current_user.nickname}님이 댓글을 답니니다."
      body = body_for_comment(comment)
    when "comments#update"
      comment = subject
      title = "@#{current_user.nickname}님이 댓글을 고칩니다."
      body = body_for_comment(comment)
    when "comments#destroy"
      comment = subject
      title = "@#{current_user.nickname}님이 댓글을 지웠습니다."
      body = body_for_comment(comment)
    when "votes#agree"
      vote = subject
      proposal = vote.proposal
      title = "@#{current_user.nickname}님이 '#{proposal.title}' 제안을 동의합니다."
      body = body_with_proposal_request(proposal.proposal_request)
    when "votes#block"
      vote = subject
      proposal = vote.proposal
      title = "@#{current_user.nickname}님이 #{proposal.title} 제안을 반대합니다."
      body = body_with_proposal_request(proposal.proposal_request)
    when "boarding_requests#create"
      title = "@#{current_user.nickname}님이 가입을 요청합니다."
    when "boarding_requests#destroy"
      boarding_request = subject
      if boarding_request.user == current_user
        title = "@#{current_user.nickname}님이 가입요청을 취소합니다."
      else
        title = "@#{current_user.nickname}님께서 @#{boarding_request.user.nickname}님의 가입요청을 취소합니다."
      end
    when "boarding_requests#accept"
      boarding_request = subject
      title = "@#{current_user.nickname}님께서 @#{boarding_request.user.nickname}님의 가입요청을 승인합니다."
    else
      return nil
    end
    return { title: title, body: body }
  end

  private

  def body_with_discussion(discussion, message = nil)
    result = ""
    result += "#{message}\n\n" if message.present?
    result +=  discussion.persisted? ? "논의: [#{discussion.title}](#{view_context.discussion_url discussion})" : "논의: #{discussion.title}"
  end

  def body_with_proposal_request(proposal_request, message = nil)
    result = ""
    result += "#{message}\n\n" if message.present?
    result +=  "논의: [#{proposal_request.discussion.title}](#{view_context.discussion_url proposal_request.discussion})\n"
    result +=  "제안요청: #{proposal_request.title}"
  end

  def body_for_comment(comment)
    result = ""
    result += "#{comment.body}\n\n"
    commentable = comment.commentable
    result +=  "논의: [#{commentable.discussion.title}](#{view_context.discussion_url commentable.discussion})\n" if comment.commentable.respond_to? :discussion
    result +=  "#{commentable.class.model_name.human}: #{view_context.truncate comment.commentable.body, length: 100}"
  end
end
