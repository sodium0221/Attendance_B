class Attendance < ApplicationRecord
  belongs_to :user

  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }

  # 当日以外の出勤・退勤時間のどちらかのみの更新は無効
  validate :only_started_at_or_finished_at_present_if_invalid
  # 出勤・退勤時間どちらも存在する時、出勤時間より早い退勤時間は無効
  validate :started_at_than_finished_at_fast_if_invalid

  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end 
  end 
  
  def only_started_at_or_finished_at_present_if_invalid
    if worked_on != Date.current
      if started_at.blank? && finished_at.present?
        errors.add(:started_at, "が必要です")
      elsif finished_at.blank? && started_at.present?
        errors.add(:finished_at, "が必要です")
      end 
    else 
      if started_at.blank? && finished_at.present?
        errors.add(:started_at, "が必要です")
      end 
    end 
  end 
      

end
