require 'test_helper'

class DiscussionsTest < ActionDispatch::IntegrationTest
  test '논의를 만듭니다' do
    sign_in(users(:one))

    post canoe_discussions_path(canoes(:canoe1)), params: {discussion: {title: 'title', body: 'body', category_id: categories(:category1).id}}

    assert assigns(:discussion).persisted?
    assert categories(:category1), assigns(:discussion).category
  end
end
