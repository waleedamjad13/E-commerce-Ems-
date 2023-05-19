# frozen_string_literal: true

# interactor for exporting discount to csv file
class ExportDiscounts < ApplicationInteractor
  def call
    csv_data = generate_csv(Discount.all)

    context.csv_data = csv_data
    context.filename = 'discount.csv'
  end

  private

  def generate_csv(discounts)
    require 'csv'

    CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Name', 'Value']

      discounts.each do |discount|
        csv << [discount.id, discount.name, discount.value]
      end
    end
  end
end
