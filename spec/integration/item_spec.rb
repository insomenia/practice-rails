require "swagger_helper"


describe "Items API" do
  # items#index
  path "/items" do
    get "상품 리스트" do
      tags "상품(Item)" # 각 섹션의 이름이 들어갑니다. tags가 동일한 path끼리 자동으로 묶입니다.
      produces "application/json"
      parameter name: :page, in: :query, type: :integer, description: "페이지 번호"
      parameter name: 'q[category_id_eq]', in: :query, type: :string, description: "카테고리 아이디"
      parameter name: 'q[name_cont]', in: :query, type: :string, description: "상품명 검색"
      parameter name: 'q[list_price_gteq]', in: :query, type: :string, description: "가격 최소값"
      parameter name: 'q[list_price_lteq]', in: :query, type: :string, description: "가격 최대값"
      parameter name: 'q[sale_price_gteq]', in: :query, type: :string, description: "할인가격 최소값"
      parameter name: 'q[sale_price_lteq]', in: :query, type: :string, description: "할인가격 최대값"
      parameter name: 'q[created_at_gteq]', in: :query, type: :string, description: "생성일 최소값"
      parameter name: 'q[created_at_lteq]', in: :query, type: :string, description: "생성일 최대값"
      parameter name: 's', in: :query, description: "sort by", schema: {
        enum: ["price desc", "price asc", "created_at desc", "created_at asc"]
      }
      

      response "200", "items found" do
        schema type: :object,
               properties: {
                 items: { 
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        user_id: { type: :integer },
                        name: { type: :string },
                        list_price: { type: :integer },
                        sale_price: { type: :integer },
                        image_path: { type: :string },
                        category: { 
                          type: :object 
                        }
                      }
                    }
                  },
                  total_count: {
                    type: :integer
                  }
                },
                required: ["id"]

        let(:id) { Item.create(name: "item_unknown").id }
        run_test!
      end
    end
  end

  # items#show
  path "/items/{id}" do
    get "상품 상세정보" do
      tags "상품(Item)"
      produces "application/json"
      parameter name: :id, in: :path, type: :string

      response "200", "item found" do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 name: { type: :string },
                 list_price: { type: :integer },
                 sale_price: { type: :integer },
                 image_path: { type: :string },
                 category: { type: :object }
               },
               required: ["id"]

        let(:id) { Item.create(name: "item_unknown").id }
        run_test!
      end

      response "404", "item not found" do
        let(:id) { "invalid" }
        run_test!
      end
    end
  end
end
