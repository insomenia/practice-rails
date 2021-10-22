class GenerateSeed
  @@users = User.ransack(email_cont: "test").result
  @@categories = Category.all
  @@items = Item.ransack(title_cont: "상품").result
  PREFIXES = ["오래된 ", "새로운 ", "흥미로운 ", "따끈따끈한 ", "센스 있는 ", "기분 좋은 ", "즐거운 ", "전문적인 "].freeze
  ADDRESSES = ["서초구 서초동", "종로구 이화동", "용산구 이촌동", "성동구 마장동", "광진구 광장동", "중랑구 면목동", "성북구 석관동", "도봉구 창동", "노원구 상계동", "은평구 수색동", "서대문구 신촌동", "마포구 공덕동", "양천구 목동", "구로구 신도림동", "영등포구 여의동", "동작구 신대방동",
               "관악구 보라매동", "강남구 신사동", "송파구 방이동", "강동구 둔촌동"].freeze
  TITLES = ["너무 좋아요", "헬로 월드", "이게 간지다", "너무 친절해요", "배송이 느려요", "또 이용할게요", "사장님이 미쳤어요", "상태가 완전 최고에요", "언제 또 입고되나요?", "사이즈 교환요", "정보좀요", "쿨거래 감사요", "항상 애용하고 있습니다", "많이 파세요", "별점 5점 드립니다",
            "칭찬칭찬합니다"].freeze
  CATEGORIES = %w[패션 뷰티 유아동 식품 주방용품 생활용품 인테리어 가전 스포츠 자동차 여행 도서 완구 문구 반려동물 건강식품].freeze
  PRICES = [10_000, 15_000, 19_000, 20_000, 30_000, 40_000, 50_000, 49_900].freeze
  def self.exec(cls)
    cls.generate_seed
  end
  %w[users].each do |inst|
    eval("def self.#{inst}
      @@#{inst}
    end
    ")
  end

  User.instance_eval do
    def generate_seed
      puts "generate user"
      5.times.each do |v|
        object_hash = {
          email: "test#{format('%02d', (v + 1))}@practice.com",
          password: "123456",
          name: "#{Faker::Name.last_name}#{Faker::Name.first_name}",
          phone: "010-#{rand(1000..9999)}-#{rand(1000..9999)}",
          gender: [1, 2].sample,
          description: Faker::Lorem.sentence(word_count: 100),
          zipcode: "111111",
          address1: "서울시 #{ADDRESSES.sample}",
          address2: "#{rand(10_000)}호",
          image: File.open("#{Rails.root}/public/photos/user#{rand(1..3)}.jpg")
        }
        User.create!(object_hash)
      end

      @@users = User.ransack(email_cont: "test").result
    end
  end

  Item.instance_eval do
    def generate_seed
      puts "generate items"
      10.times do
        price_samples = [[50_000, 50_000], [50_000, 45_000], [40_000, 39_800], [5000, 5000], [60_000, 59_000], [80_000, 72_000]]
        item_price_sample = price_samples.sample

        object_hash = {
          name: "#{PREFIXES.sample} 상품",
          list_price: item_price_sample[0],
          sale_price: item_price_sample[1],
          category: Category.all.sample,
          description: Faker::Lorem.sentence(word_count: 100),
          image: File.open(Dir["#{Rails.root}/public/seed/*"].sample),
          zipcode: "111111",
          address1: "서울시 #{ADDRESSES.sample}",
          address2: "#{rand(10_000)}호",
          user_id: @@users.sample&.id,
          category_id: @@categories.sample.id
        }

        object = Item.create!(object_hash)

        3.times { object.images.create(image: File.open(Dir["#{Rails.root}/public/seed/*"].sample)) }
      end
    end
  end

  Category.instance_eval do
    def generate_seed
      puts "generate categories"
      CATEGORIES.each_with_index do |category_title, index|
        create(
          title: category_title,
          body: Faker::Lorem.sentence(word_count: 100),
          position: index,
          image: File.open("#{Rails.root}/public/icons/icon#{index}.png")
        )
      end
    end
  end
end
