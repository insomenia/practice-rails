require "swagger_helper"

ORDER_PROPERTIES = {
  id: { type: :integer },
  status: { type: :string },
  receiver_name: { type: :string },
  receiver_phone: { type: :string },
  zipcode: { type: :string },
  address1: { type: :string },
  address2: { type: :string }
}

describe "Orders API" do
  path "/cart" do
    get "장바구니 조회" do
      security [ Bearer: []]
      tags "주문(Order)"
      consumes "application/json"
     
      response "200", "order found" do
        schema type: :object,
               properties: ORDER_PROPERTIES,
               required: %w[id status receiver_name receiver_phone zipcode address1 address2]

        let(:order) { Order.create(status: "cart", receiver_name: "anonymous") }
        run_test!
      end
    end
  end

  # orders#index
  path "/orders" do
    get "주문 리스트" do
      tags "주문(Order)"
      produces "application/json"
      response "200", "items found" do
        schema type: :object,
               properties: ORDER_PROPERTIES,
               required: %w[id status receiver_name receiver_phone zipcode address1 address2]

        let(:id) { Order.create(status: "cart", receiver_name: "anonymous").id }
        run_test!
      end

      response "404", "order not found" do
        let(:id) { "invalid" }
        run_test!
      end
    end
  end

  # orders#show
  path "/orders/{id}" do
    get "주문 상세정보" do
      tags "주문(Order)"
      produces "application/json"
      parameter name: :id, in: :path, type: :string

      response "200", "order found" do
        schema type: :object,
               properties: ORDER_PROPERTIES,
               required: %w[id status receiver_name receiver_phone zipcode address1 address2]

        let(:id) { Order.create(status: "cart", receiver_name: "anonymous").id }
        run_test!
      end

      response "404", "order not found" do
        let(:id) { "invalid" }
        run_test!
      end
    end
  end

  # order#update
  path "/orders/{id}" do
    patch "주문하기" do
      tags "주문(Order)"
      consumes "application/json"
      parameter name: :id, in: :path, type: :string
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          receiver_name: { type: :string, default: "" },
          receiver_phone: { type: :string, default: "" },
          zipcode: { type: :string, default: "" },
          address1: { type: :string, default: "" },
          address2: { type: :string, default: "" }
        },
        required: %w[receiver_name receiver_phone zipcode address1 address2]
      }

      response "201", "order complete" do
        let(:line_item) { { receiver_name: "unknown", receiver_phone: "010-0000-0000", zipcode: "00000", address1: "", address2: "" } }
        run_test!
      end

      response "422", "invalid request" do
        let(:line_item) { {  receiver_name: "unknown", receiver_phone: "010-0000-0000", zipcode: "00000", address1: "", address2: "" } }
        run_test!
      end
    end
  end
end
