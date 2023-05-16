# frozen_string_literal: true

# Base class for view models.
#
class ApplicationView
  #
  # Returns the model object initialized with
  #
  attr_reader :model

  # Returns the current user accessing the platform (not required to be set)
  #
  attr_accessor :current_user

  # Returns the name of the model, used when this object is passed to
  # determine a policy.
  #
  delegate :model_name, :to_param, to: :model

  # Initializes a new view model and exposes the passed model
  # internally through the private +model+ method.
  #
  # It is a convention to alias the +model+ method to the actual
  # model name in subclasses.
  #
  def initialize(model, current_user: nil, **_options)
    @model = model
    @current_user = current_user
  end

  # Exposes account belonging current_user if set
  #
  def current_account
    current_user&.account
  end

  # Expose view helpers to view models through the +h+.
  #
  def h
    @h ||= Helper.new
  end

  # Helper method if a view needs to reference a policy
  #
  # @param record_or_type [ActiveRecord::Model, Symbol] Model or name of policy
  # @param record [ActiveRecord::Model] Model
  #

  # Returns if the other view has the same model
  #
  # @return [Boolean]
  #
  def eql?(other)
    model == other&.model
  end

  # Returns the model represented by the view
  #
  def to_model
    model
  end

  # Returns a signed Global ID for the model
  #
  def to_sgid
    model.to_sgid.to_s
  end

  # Returns a custom label for the key passed using the user's account settings.
  #
  # The view model must be instatiated with a user when using this method
  #

  # Returns an array of view models built from each of the models
  # passed.
  #
  # @param models [Array] Array of model objects
  # @param user [User] User to use for context in the view model
  #
  # @return [Array] Array of view models
  #
  def self.collection(models, current_user: nil, **options)
    collection = models.map do |model|
      new(model, current_user: current_user, **options)
    end

    return collection unless models.respond_to?(:total_count)

    Kaminari.paginate_array(
      collection,
      limit: models.limit_value,
      offset: models.offset_value,
      total_count: models.total_count
    )
  rescue ArgumentError
    raise "#{name} does not support collections"
  end

  # Route helpers
  #
  def r
    Rails.application.routes.url_helpers
  end

  #
  # Helper class to encapsulate view helpers needed in view models
  #
  class Helper
    include ActionView::Helpers::NumberHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::DateHelper
    include ApplicationHelper
  end
end
