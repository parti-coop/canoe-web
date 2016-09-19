require 'test_helper'

class MembershipsTest < ActionDispatch::IntegrationTest
  test '카누를 만들면 멤버가 됩니다' do
    sign_in(users(:one))

    post canoes_path, params: {canoe: {title: 'canoe', body: 'body'}}

    assert assigns(:canoe).persisted?
    assert assigns(:canoe).member? users(:one)
  end

  test '카누를 탈퇴합니다' do
    assert canoes(:canoe1).member? users(:one)
    sign_in(users(:one))

    delete cancel_canoe_memberships_path(canoe_id: canoes(:canoe1))

    refute canoes(:canoe1).member? users(:one)
  end
end
