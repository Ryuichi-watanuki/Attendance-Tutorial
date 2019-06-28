module UserDecorator
  
  # 所属の有無による表示切り替え
  def department_status
    department? ? department : "未所属"
  end
end
