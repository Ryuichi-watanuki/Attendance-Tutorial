module AttendanceDecorator
  
  # 単位指定なしで出勤時間を表示する
  def work_start
    l(started_at, format: :time) if started_at?
  end
  
  # あれば出勤時間を表示する（15分単位）
  def started_status
    l(started_at_to_15_in_minutes(started_at), format: :time) if started_at?
  end
  
  # あれば退勤時間を表示する（15分単位）
  def finished_status
    l(finished_at_to_15_in_minutes(finished_at), format: :time) if finished_at?
  end
end
