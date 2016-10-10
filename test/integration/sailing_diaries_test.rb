require 'test_helper'

class SailingDiariesTest < ActionDispatch::IntegrationTest
  test '감정을 잡아 냅니다' do
    sign_in(users(:one))

    post canoe_sailing_diaries_path(canoe_id: canoes(:canoe1).id), params: { sailing_diary: { body: '이런저런 :즐거움: :기대:', sailed_on: '2016-10-10' } }

    assert assigns(:sailing_diary).persisted?
    assert assigns(:sailing_diary).emotions.exists? sign: :joy
    assert assigns(:sailing_diary).emotions.exists? sign: :hope
  end
end
