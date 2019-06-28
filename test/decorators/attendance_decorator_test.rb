require 'test_helper'

class AttendanceDecoratorTest < ActiveSupport::TestCase
  def setup
    @attendance = Attendance.new.extend AttendanceDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
