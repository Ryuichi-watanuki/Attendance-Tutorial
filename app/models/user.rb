class User < ApplicationRecord
  # 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  
  has_many :attendances, dependent: :destroy
  
  validates :name,  presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true    
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :department, length: { in: 3..50 }, allow_blank: true
  validates :basic_time, presence: true
  validates :work_time, presence: true
  
  # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # 渡された日付の月を対象に一月分のデータが存在するか判定します。
  def attendances_exists?(day)
    one_month_dates = [*day.beginning_of_month..day.end_of_month].count
    self.attendances.where(worked_on: day.beginning_of_month..day.end_of_month).
    count == one_month_dates ? true : false
  end
  
  def one_month_attendances(first_day, last_day)
    self.attendances.where(worked_on: first_day..last_day)
  end
  
  # 引数に指定したカラム名を返します。
  def self.column_name(sym)
    self.human_attribute_name(sym)
  end
end
