require 'action_view'
require 'action_view/helpers'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = %w(black white orange brown)

  has_many :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy

  validates :birth_date, :color, :name, :sex, :description, presence: true

  validates :color, inclusion: COLORS
  validates :sex, inclusion: ["M", "F"]
end
