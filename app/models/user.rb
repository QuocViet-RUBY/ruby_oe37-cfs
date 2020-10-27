class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_many :categories, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :from_user_shares, class_name: "Share",
    foreign_key: "from_user_id", dependent: :destroy
  has_many :to_user_shares, class_name: "Share",
    foreign_key: "to_user_id", dependent: :destroy

  validates :full_name, presence: true,
    length: {maximum: Settings.max_full_name}
  validates :email, presence: true,
    length: {maximum: Settings.max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.min_pass},
    allow_nil: true

  enum delete_flag: {activate: 0, inactive: 1}
  enum role: {admin: 0, user: 1}
  scope :newest, ->{order created_at: :desc}

  def self.to_csv options = {}
    column_names = %w(full_name email activated created_at update_at)
    CSV.generate(options) do |csv|
      csv << column_names
      all.find_each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
