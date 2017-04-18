class Cat < ApplicationRecord
  COLORS = %w(black white orange brown)
  validates :birth_date, :color, :name, :sex, :description, presence: true

  validates :color, inclusion: COLORS
  validates :sex, inclusion: ["M", "F"]
end
