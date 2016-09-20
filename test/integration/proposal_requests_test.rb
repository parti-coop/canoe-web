require 'test_helper'

class ProposalRequestsTest < ActionDispatch::IntegrationTest
  test 'PR을 얼립니다' do
    sign_in(users(:one))
    refute proposal_requests(:proposal_request1).archived?

    patch archive_proposal_request_path(proposal_requests(:proposal_request1))
    assert assigns(:proposal_request).archived?

    assigns(:proposal_request).reload

    patch inbox_proposal_request_path(proposal_requests(:proposal_request1))
    refute assigns(:proposal_request).archived?
  end
end
