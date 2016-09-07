require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  test '댓글을 답니다' do
    sign_in(users(:one))

    post opinion_comments_path(opinions(:opinion1)), params: {comment: {body: 'body'}}

    assert assigns(:comment).persisted?
    assert 'body', assigns(:comment).body
    assert users(:one), assigns(:comment).user
    assert opinions(:opinion1), assigns(:comment).opinion
  end
end
