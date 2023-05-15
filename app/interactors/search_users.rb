class SearchUsers < ApplicationInteractor

  def call
    search_terms = context.search_terms.split(" ")

    users = User.all
    users = users.where("firstname LIKE :term OR lastname LIKE :term OR email LIKE :term", term: "%#{search_terms.first}%")

    context.users = users
  end
end
