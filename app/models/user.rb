# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: {case_sensitive: false} # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :username, length: {minimum: 3, maximum: 25}, if: :username?

  has_secure_password
end
