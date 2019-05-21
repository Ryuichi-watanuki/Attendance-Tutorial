module ApplicationHelper

  # ページごとにタイトルを返す
  def full_title(page_name = "")
    base_title = "AttendanceApp"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
  
  # 渡された日付の月を対象に初日から末日までの配列を返します。
  def one_month_dates(day)
    [*day.beginning_of_month..day.end_of_month]
  end
end