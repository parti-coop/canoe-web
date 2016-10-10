module V1
  module Entities
    class CanoeEntity < Grape::Entity
      expose :id
      expose :title
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
