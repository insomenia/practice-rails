class User < ApplicationRecord
  paginates_per 8
  include ImageUrl
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  # :validatable,

  has_many :items, dependent: :nullify
  has_many :orders, dependent: :destroy
  enum gender: { unknown: 0, male: 1, female: 2 }

  has_one :cart, -> { cart }, class_name: "Order"

  validates :uuid, uniqueness: true

  def cart
    super || create_cart(status: :cart)
  end

  USER_COLUMNS = %i[name email phone image address1 address2 zipcode gender customs_number role accept_sms accept_email user_type en_address agree_tos agree_privacy description password
                    password_confirmation].freeze
end
