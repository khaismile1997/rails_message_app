# frozen_string_literal: true

class ChangePasswordForm
  include ActiveModel::Validations

  validates_presence_of :old_password, :password, :password_confirmation
  validates_confirmation_of :password
  validate :verify_old_password

  attr_accessor :old_password, :password, :password_confirmation

  def initialize(user)
    @user = user
    @old_password = nil
    @password = nil
    @password_confirmation = nil
  end

  def submit(params)
    @old_password = params["old_password"]
    @password = params["password"]
    @password_confirmation = params["password_confirmation"]

    if valid?
      @user.password = password
      @user.password_confirmation = password_confirmation
      @user.save!
      true
    else
      false
    end
  end

  def verify_old_password
    errors.add(:old_password, "was incorrect.") unless @user.authenticate(old_password)
  end

  def persisted?
    false
  end
end
