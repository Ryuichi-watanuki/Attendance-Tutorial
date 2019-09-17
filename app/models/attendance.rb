class Attendance < ApplicationRecord
  belongs_to :user
  
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  # 出勤時間が存在しない場合、退勤時間は無効
  validate :finished_at_is_invalid_without_a_started_at
  # 出勤・退勤時間どちらも存在する時、出勤時間より早い退勤時間は無効
  validate :started_at_than_finished_at_fast_if_invalid
  
  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
  
  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end
  end
  
  class << self
    # 現在出勤している勤怠データを返す
    def working
      self.where(worked_on: Date.current, finished_at: nil).
      where.not(started_at: nil).
      order(:user_id)
    end
  end
  
  # 親モデルとなるユーザーの指定の1ヶ月分のデータを取得する
  scope :one_month_dates, -> (first_day, last_day) {
    where(worked_on: first_day..last_day).order(:worked_on)
  }
  scope :worked_dates, -> { where.not(started_at: nil) }
  scope :testes, -> { working.worked_dates }
  
end
