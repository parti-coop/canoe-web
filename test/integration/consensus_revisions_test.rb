require 'test_helper'

class ConsensusRevisionsTest < ActionDispatch::IntegrationTest
  test '합의를 만들면 생깁니다' do
    sign_in users(:one)
    patch consensus_discussion_path((discussions(:discussion1)), params: {discussion: {consensus: 'new consensus'}})

    assert_equal 'new consensus', assigns(:discussion).reload.consensus
    revision = assigns(:discussion).consensus_revisions.current
    assert_equal assigns(:discussion).consensus, revision.body

    patch consensus_discussion_path((discussions(:discussion1)), params: {discussion: {consensus: 'renew consensus'}})
    assert_equal 'renew consensus', assigns(:discussion).reload.consensus
    revision = assigns(:discussion).consensus_revisions.current
    assert_equal assigns(:discussion).consensus, revision.body
    assert_equal 2, assigns(:discussion).consensus_revisions.count
  end

  test '이전 합의와 같으면 저장되지 않습니다.' do
    sign_in users(:one)
    patch consensus_discussion_path((discussions(:discussion1)), params: {discussion: {consensus: 'consensus'}})

    assert_no_difference 'ConsensusRevision.count' do
        patch consensus_discussion_path((discussions(:discussion1)), params: {discussion: {consensus: 'consensus'}})
    end
  end
end
