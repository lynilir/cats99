class CatRentalRequest < ApplicationRecord
  belongs_to :cats,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "Cat"

  validates(
    :cat_id,
    :end_date,
    :start_date,
    :status,
    presence: true
  )
  validates :status, inclusion: %w(APPROVED DENIED PENDING)
  validate :start_must_come_before_end
  validate :does_not_overlap_approved_request

  def overlapping_requests
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
         NOT( (start_date > :end_date) OR (end_date < :start_date) )
      SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end
  
  def start_must_come_before_end
    return if start_date < end_date
    errors[:start_date] << "must come before end date"
    errors[:end_date] << "must come after start date"
  end
end
