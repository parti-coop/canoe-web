require 'test_helper'

class MembershipsTest < ActionDispatch::IntegrationTest
  test '빠띠를 만들면 멤버가 됩니다' do
    sign_in(users(:one))

    post canoes_path, params: {canoe: {title: 'canoe', body: 'body'}}

    assert assigns(:canoe).persisted?
    assert assigns(:canoe).member? users(:one)
  end
end
