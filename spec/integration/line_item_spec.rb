require 'swagger_helper'

describe "LineItems API" do

  # orders#create
  path '/orders' do
    post '장바구니 생성' do
      tags '장바구니(LineItem)' # 각 섹션의 이름이 들어갑니다. tags가 동일한 path끼리 자동으로 묶입니다.
      consumes 'application/json'
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          status: { type: :string, default: 'cart' }
        },
        required: [ 'user_id', 'status' ]
      }

      response '201', 'order created' do
        let(:order) { { receiver_name: 'foo', receiver_phone: '010-1111-2222' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:order) { { receiver_name: 'foo' } }
        run_test!
      end
    end
  end

  path '/line_items' do
    post '장바구니 담기' do
      tags '장바구니(LineItem)'
      consumes 'application/json'
      parameter name: :line_item, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          item_id: { type: :integer },
          quantity: { type: :integer },
        },
        required: [ 'user_id', 'item_id', 'quantity' ]
      }

      response '201', 'cart item added' do
        let(:line_item) { { user_id: 1, item_id: 1, quantity: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:line_item) { { user_id: 1, item_id: 1, quantity: 1 } }
        run_test!
      end
    end
  end

end
