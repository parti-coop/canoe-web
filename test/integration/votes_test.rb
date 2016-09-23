require 'test_helper'

class VotesTest < ActionDispatch::IntegrationTest
  test 'PR에 동의합니다' do

    refute proposals('proposal1').agreed_by?(users(:one))
    refute proposals('proposal1').voted_by?(users(:one))

    assert_difference(lambda{ proposals('proposal1').reload.agree_votes_count }, 1) do
      sign_in(users(:one))
      post agree_proposal_path(proposals('proposal1'))
    end

    assert proposals('proposal1').agreed_by?(users(:one))
    assert proposals('proposal1').voted_by?(users(:one))
  end

  test 'PR에 반대합니다' do
    refute proposals('proposal1').blocked_by?(users(:one))
    refute proposals('proposal1').voted_by?(users(:one))

    assert_difference(lambda{ proposals('proposal1').reload.block_votes_count }, 1) do
      sign_in(users(:one))
      post block_proposal_path(proposals('proposal1'))
    end

    assert proposals('proposal1').blocked_by?(users(:one))
    assert proposals('proposal1').voted_by?(users(:one))
  end

  test 'PR에 두번 동의하면 아무런 일도 일어나지 않습니다' do
    sign_in(users(:one))

    post agree_proposal_path(proposals('proposal1'))
    assert_no_difference 'Vote.count' do
      post agree_proposal_path(proposals('proposal1'))
    end
  end

  test 'PR에 찬성했다가 반대합니다' do
    sign_in(users(:one))

    post agree_proposal_path(proposals('proposal1'))
    assert_no_difference 'Vote.count' do
      post block_proposal_path(proposals('proposal1'))
    end

    assert proposals('proposal1').blocked_by?(users(:one))
    assert proposals('proposal1').voted_by?(users(:one))
  end

  test 'PR에 찬성했다가 취소합니다' do
    sign_in(users(:one))

    post agree_proposal_path(proposals('proposal1'))
    assert_difference 'Vote.count', -1 do
      delete vote_proposal_path(proposals('proposal1'))
    end

    refute proposals('proposal1').agreed_by?(users(:one))
    refute proposals('proposal1').voted_by?(users(:one))
  end
end
