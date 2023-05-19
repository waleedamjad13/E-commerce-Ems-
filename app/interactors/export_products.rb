# frozen_string_literal: true

# interactor for exporting products to csv file
class ExportProducts < ApplicationInteractor
  def call
    csv_data = generate_csv(Product.all)

    context.csv_data = csv_data
    context.filename = 'products.csv'
  end

  private

  def generate_csv(products)
    require 'csv'

    CSV.generate(headers: true) do |csv|
      csv << %w[Tilte Description Price Status]

      products.each do |product|
        csv << [product.title, product.description, product.price,
                product.status]
      end
    end
  end
end
