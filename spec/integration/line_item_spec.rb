require "swagger_helper"

LINE_ITEM_PROPERTIES = {
  id: { type: :integer },
  order_id: { type: :integer },
  quantity: { type: :integer },
  total: { type: :integer },
  item_id: { type: :integer }

}

ORDER_PROPERTIES = {
  id: { type: :integer },
  status: { type: :string },
  receiver_name: { type: :string },
  receiver_phone: { type: :string },
  zipcode: { type: :string },
  address1: { type: :string },
  address2: { type: :string },
  line_items: { type: :array, items: { type: :object, properties: LINE_ITEM_PROPERTIES } }
}

describe "LineItems API" do
  path "/cart" do
    get "장바구니 조회" do
      security [Bearer: []]
      tags "LineItem"
      produces "application/json"
      response "200", "order found" do
        schema type: :object,
               properties: ORDER_PROPERTIES,
               required: %w[id status receiver_name receiver_phone zipcode address1 address2]

        let(:order) { Order.create(status: "cart", receiver_name: "anonymous") }
        run_test!
      end
    end
  end

  path "/line_items" do
    post "LineItem 추가" do
      security [Bearer: []]
      tags "LineItem"
      produces "application/json"
      consumes "application/json"
      parameter name: :line_item, in: :body, schema: {
        type: :object,
        properties: LINE_ITEM_PROPERTIES.except(:id, :order_id, :total)
      }

      response "200", "create success" do
        schema type: :object,
               properties: LINE_ITEM_PROPERTIES
        let(:order) { Order.create(status: "cart", receiver_name: "anonymous") }
        run_test!
      end
    end
  end
  path "/line_items/{id}" do
    patch "LineItem 업데이트" do
      security [Bearer: []]
      tags "LineItem"
      produces "application/json"
      consumes "application/json"
      parameter name: :id, in: :path, type: :string
      parameter name: :line_item, in: :body, schema: {
        type: :object,
        properties: LINE_ITEM_PROPERTIES.except(:id, :order_id, :total, :item_id)
      }

      response "200", "update success" do
        schema type: :object,
               properties: LINE_ITEM_PROPERTIES
        let(:order) { Order.create(status: "cart", receiver_name: "anonymous") }
        run_test!
      end
    end

    delete "LineItem 삭제" do
      security [Bearer: []]
      tags "LineItem"
      produces "application/json"
      consumes "application/json"
      parameter name: :id, in: :path, type: :string
      response "204", "delete success" do
        run_test!
      end
    end
  end
end
