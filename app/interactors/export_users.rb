# frozen_string_literal: true

# interactor for exporting users to csv file
class ExportUsers
  include Interactor

  def call
    search_terms = context.search_terms
    users = User.search_by_name(search_terms)

    csv_data = generate_csv(users)

    context.csv_data = csv_data
    context.filename = 'users.csv'
  end

  private

  def generate_csv(users)
    require 'csv'

    CSV.generate(headers: true) do |csv|
      csv << ['First Name', 'Last Name', 'Email']

      users.each do |user|
        csv << [user.firstname, user.lastname, user.email, user.confirmed?]
      end
    end
  end
end
