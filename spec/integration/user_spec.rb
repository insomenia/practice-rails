require "swagger_helper"

describe "User API" do
  # orders#create
  # path '/create_user' do
  #   get '사용자 정보 발급(주문, 장바구니 API 사용 시 필수)' do
  #     tags '사용자'
  #     produces 'application/json'
  #
  #     response '200', 'user found' do
  #       schema type: :object,
  #         properties: {
  #           id: { type: :integer }
  #         },
  #         required: ['id']
  #
  #       let(:id) { User.create(email: "anonymous@practice.com", password: "#{SecureRandom.hex(4)}", password_confirmation: "#{SecureRandom.hex(4)}").id }
  #       run_test!
  #     end
  #
  #   end
  # end

  path "" do
    post "사용자 정보 확인" do
      tags "사용자"
      consumes "application/x-amz-json-1.1"
      parameter name: "X-Amz-Target", in: :header, type: :string, schema: {
        default: "AWSCognitoIdentityProviderService.SignUp"
      }
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          AuthFlow: { type: :string, default: "USER_PASSWORD_AUTH" },
          ClientId: { type: :string, default: "7p64rveq2l3fhk9h47mt80vo9u" },
          AuthParameters: {
            type: :object,
            properties: {
              USERNAME: { type: :string, default: "" },
              PASSWORD: { type: :string, default: "" }
            }
          }
        },
        required: %w[AuthFlow ClientId USERNAME PASSWORD]
      }

      response "200", "user found" do
        schema type: :object,
               properties: {
                 id: { type: :integer }
               },
               required: ["id"]

        let(:id) { User.create(email: "anonymous@practice.com", password: SecureRandom.hex(4).to_s, password_confirmation: SecureRandom.hex(4).to_s).id }
        run_test!
      end
    end
  end

  path "/" do
    post "사용자 생성" do
      tags "사용자"
      consumes "application/x-amz-json-1.1"
      parameter name: "X-Amz-Target", in: :header, type: :string, schema: {
        default: "AWSCognitoIdentityProviderService.SignUp"
      }

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          ClientId: { type: :string, default: "7p64rveq2l3fhk9h47mt80vo9u" },
          Password: { type: :string, default: "" },
          Username: { type: :string, default: "" },
          UserStatus: { type: :string, default: "CONFIRMED" }
        },
        required: %w[Password ClientId Username UserStatus]
      }

      response "200", "user found" do
        schema type: :object,
               properties: {
                 id: { type: :integer }
               },
               required: ["id"]

        let(:id) { User.create(email: "anonymous@practice.com", password: SecureRandom.hex(4).to_s, password_confirmation: SecureRandom.hex(4).to_s).id }
        run_test!
      end
    end
  end
end
