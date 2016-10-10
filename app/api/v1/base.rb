module V1
  module Entities
    class EmotionEntity < Grape::Entity
      expose :id, :sign
      expose :text do |emotion|
        emotion.sign_text
      end
    end

    class UserEntity < Grape::Entity
      expose :email, :image_url, :nickname
    end

    class CategoryEntity < Grape::Entity
      expose :name, :id
    end

    class CommentEntity < Grape::Entity
      expose :id, :body, :created_at
      expose :user, using: V1::Entities::UserEntity
    end

    class DiscussionEntity < Grape::Entity
      expose :id, :title, :body, :opinions_count, :archived_at, :created_at
      expose :category, using: V1::Entities::CategoryEntity
      expose :user, using: V1::Entities::UserEntity
    end

    class SailingDiaryEntity < Grape::Entity
      expose :id, :body, :sailed_on, :created_at
      expose :user, using: V1::Entities::UserEntity
      expose :comments, using: V1::Entities::CommentEntity
      expose :emotions, using: V1::Entities::EmotionEntity
    end

    class CanoeEntity < Grape::Entity
      expose :id, :title, :body, :logo_url, :boarding_requests_count, :created_at
      expose :user, using: V1::Entities::UserEntity
    end

    class CanoeDetailEntity < CanoeEntity
      expose :categories, using: V1::Entities::CategoryEntity
      expose :recent_discussions, using: V1::Entities::DiscussionEntity do |canoe|
        canoe.discussions.recent.limit(10)
      end
      expose :recent_sailing_diaries, using: V1::Entities::SailingDiaryEntity do |canoe|
        canoe.sailing_diaries.recent.limit(10)
      end
    end
  end

  class Base < Grape::API
    helpers APIHelpers
    include APIDefaults

    before do
      unless "/api/v1/docs" == env['PATH_INFO']
        current_user = User.find_by nickname: CGI.unescape(headers['Authorization'] || '')
        error! 'Unauthorized', 401, 'X-Error-Detail': 'Invalid token.' if current_user.blank?
      end
    end

    desc '해당 사용자가 가입한 카누를 조회합니다'
    get :canoes do
      present :canoes, Canoe.all, with: V1::Entities::CanoeEntity
    end

    resource :canoes do
      desc '카누 상세 정보를 조회합니다'
      route_param :id do
        get do
          canoe = Canoe.find(params[:id])
          present :canoe, canoe, with: V1::Entities::CanoeDetailEntity
        end
      end
    end


    add_swagger_documentation \
      hide_documentation_path: true,
      base_path: '/api/v1',
      mount_path: 'docs',
      api_version: "v1",
      doc_version: "v1",
      hide_format: true,
      info: {
        title: "Canoe V1",
        description: "카누 API입니다.",
        models: [V1::Entities::CanoeEntity]
      }
  end
end
