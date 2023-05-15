class SearchUsers < ApplicationInteractor

  def call
    search_terms = context.search_terms.split(" ")

    users = User.all
    users = users.where("firstname LIKE ? OR lastname LIKE ?",
                        "%#{search_terms.first}%", "%#{search_terms.last}%")

    context.users = users
  end
end
