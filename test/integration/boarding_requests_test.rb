require 'test_helper'

class BoardingRequestsTest < ActionDispatch::IntegrationTest
  test '가입 요청을 합니다' do
    refute canoes(:canoe1).boarding_requested? users(:two)

    sign_in(users(:two))

    post boarding_requests_path, params: {canoe_id: canoes(:canoe1).id}

    assert assigns(:boarding_request).persisted?
    assert canoes(:canoe1).boarding_requested? users(:two)
  end

  test '이미 가입 요청했으면 요청이 무시됩니다' do
    assert canoes(:canoe1).boarding_requested? users(:three)

    sign_in(users(:three))

    post boarding_requests_path, params: {canoe_id: canoes(:canoe1).id}

    refute assigns(:boarding_request).persisted?
  end

  test '이미 가입되었으면 요청이 무시됩니다' do
    assert canoes(:canoe1).member? users(:one)

    sign_in(users(:one))

    post boarding_requests_path, params: {canoe_id: canoes(:canoe1).id}

    refute assigns(:boarding_request).persisted?
  end

  test '가입을 허가합니다' do
    refute canoes(:canoe1).member? users(:three)

    sign_in(users(:one))

    post accept_boarding_request_path(boarding_requests(:boarding_request1))

    assert canoes(:canoe1).reload.member? users(:three)
  end
end
