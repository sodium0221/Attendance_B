module AttendancesHelper
  
  def attendance_state(attendance)
    # 受け取った Attendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出社' if attendance.started_at.nil?
    end 
    false
  end 
  
  def quitting_state(attendance)
    if Date.current == attendance.worked_on
      return '退社' if attendance.started_at.present? && attendance.finished_at.nil?
    end 
    false
  end 
end
