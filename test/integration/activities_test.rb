require 'test_helper'

class ActivitiesTest < ActionDispatch::IntegrationTest
  test 'opinion을 달면 생깁니다' do
    sign_in(users(:one))

    post discussion_opinions_path(discussions(:discussion1)), params: {opinion: {body: 'body' }}

    activity = Activity.find_by(trackable: assigns(:opinion))
    assert activity.present?
    assert_equal activity.discussion, discussions(:discussion1)
    assert_equal activity.action, 'opinion'
    assert_equal activity.user, users(:one)
  end

  test 'PR이 만들어지면 생깁니다' do
    sign_in(users(:one))
    post discussion_proposal_requests_path(discussions(:discussion1)), params: {proposal_request: {title: '제목'}}

    activity = Activity.find_by(trackable: assigns(:proposal_request))
    assert activity.present?
    assert_equal activity.discussion, discussions(:discussion1)
    assert_equal activity.action, 'proposal_requests/create'
    assert_equal activity.user, users(:one)
  end

  test 'PR에 동의하면 생깁니다' do
    sign_in(users(:one))
    post agree_proposal_path(proposals('proposal1'))

    activity = Activity.find_by(trackable: assigns(:vote))
    assert activity.present?
    assert_equal activity.discussion, discussions(:discussion1)
    assert_equal activity.action, 'votes/agree'
    assert_equal activity.user, users(:one)
  end

  test 'PR에 두번 동의하면 아무런 일도 일어나지 않습니다' do
    sign_in(users(:one))

    post agree_proposal_path(proposals('proposal1'))
    assert_no_difference 'Activity.count' do
      post agree_proposal_path(proposals('proposal1'))
    end
  end

  test 'PR에 찬성했다가 반대하면 생겨요' do
    sign_in(users(:one))

    post agree_proposal_path(proposals('proposal1'))
    assert_difference 'Activity.count', 1 do
      post block_proposal_path(proposals('proposal1'))
    end
  end

  test '합의사항이 작성되면 생겨요' do
    sign_in users(:one)
    patch consensus_discussion_path((discussions(:discussion1)), params: {discussion: {consensus: 'new consensus'}})

    activity = Activity.find_by(trackable: assigns(:consensus_revision))
    assert activity.present?
    assert_equal activity.discussion, discussions(:discussion1)
    assert_equal activity.action, 'discussions/consensus'
    assert_equal activity.user, users(:one)
  end
end
