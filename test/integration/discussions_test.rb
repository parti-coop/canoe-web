require 'test_helper'

class DiscussionsTest < ActionDispatch::IntegrationTest
  test '논의를 만듭니다' do
    sign_in(users(:one))

    post canoe_discussions_path(canoes(:canoe1)), params: {discussion: {title: 'title', body: 'body', category_id: categories(:category1).id}}

    assert assigns(:discussion).persisted?
    assert categories(:category1), assigns(:discussion).category
  end

  test '논의를 얼립니다' do
    sign_in(users(:one))
    refute discussions(:discussion1).archived?

    patch archive_discussion_path(discussions(:discussion1))
    assert assigns(:discussion).archived?

    patch inbox_discussion_path(discussions(:discussion1))
    refute assigns(:discussion).archived?
  end
end
