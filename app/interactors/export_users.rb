# frozen_string_literal: true

# interactor for exporting users to csv file
class ExportUsers < ApplicationInteractor
  def call
    csv_data = generate_csv(User.non_admins)

    context.csv_data = csv_data
    context.filename = 'users.csv'
  end

  private

  def generate_csv(users)
    require 'csv'

    CSV.generate(headers: true) do |csv|
      csv << ['First Name', 'Last Name', 'Email', 'Confirmation']

      users.each do |user|
        csv << [user.firstname, user.lastname, user.email, user.confirmed?]
      end
    end
  end
end
