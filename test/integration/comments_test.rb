require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  test '의견에 댓글을 답니다' do
    sign_in(users(:one))

    post opinion_comments_path(opinions(:opinion1)), params: {comment: {body: 'body'}}

    assert assigns(:comment).persisted?
    assert 'body', assigns(:comment).body
    assert users(:one), assigns(:comment).user
    assert opinions(:opinion1), assigns(:comment).commentable
  end

  test '일지에 댓글을 답니다' do
    sign_in(users(:one))

    post sailing_diary_comments_path(sailing_diaries(:sailing_diary1)), params: {comment: {body: 'body'}}

    assert assigns(:comment).persisted?
    assert 'body', assigns(:comment).body
    assert users(:one), assigns(:comment).user
    assert sailing_diaries(:sailing_diary1), assigns(:comment).commentable
  end
end
