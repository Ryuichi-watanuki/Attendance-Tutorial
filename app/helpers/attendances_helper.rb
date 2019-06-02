module AttendancesHelper
  
  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end
  
  # 出勤時間と退勤時間を受け取り、在社時間を計算して返します。
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
  
  # 出勤時間を15分単位にして返します（切り上げ）
  def started_at_to_15_in_minutes(started_at)
    case started_at.min
    when 0..14
      started_at.change(min: 15)
    when 15..29
      started_at.change(min: 30)
    when 30..44
      started_at.change(min: 45)
    when 45..59
      started_at.change(hour: started_at.hour + 1, min: 0)
    end
  end
  
  # 退勤時間を15分単位にして返します（切り捨て）
  def finished_at_to_15_in_minutes(finished_at)
    case finished_at.min
    when 0..14
      finished_at.change(min: 0)
    when 15..29
      finished_at.change(min: 15)
    when 30..44
      finished_at.change(min: 30)
    when 45..59
      finished_at.change(min: 45)
    end
  end
end
