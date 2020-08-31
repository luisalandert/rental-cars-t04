class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_one :car_rental

  before_create :generate_token

  # def scheduled?
  #   car_rental.blank?
  # end

  # def in_progress?
  #   car_rental && car_rental.end_date.blank?
  # end

  # def finalized?
  #   car_rental && car_rental.end_date.present?
  # end

  def total
    return car_rental.total if car_rental.present?

    number_of_days_rented = end_date - start_date

    number_of_days_rented * car_category.daily_price
  end

  private

  def generate_token
    self.token = SecureRandom.alphanumeric(6).upcase
  end
end
