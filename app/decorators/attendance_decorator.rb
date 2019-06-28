module AttendanceDecorator
  
  # あれば出勤時間を表示する
  def started_status
    l(started_at_to_15_in_minutes(started_at), format: :time) if started_at?
  end
  
  # あれば退勤時間を表示する
  def finished_status
    l(finished_at_to_15_in_minutes(finished_at), format: :time) if finished_at?
  end
end
