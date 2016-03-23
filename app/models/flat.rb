class Flat < ActiveRecord::Base
  include Tokenable

  has_many	:users
  has_many  :billcategories
  has_many  :shareditems, -> { order 'name asc' }
  has_many	:shoppinglists, -> { order 'created_at asc' }
  has_many :todos, -> { order 'created_at asc' }
  has_many	:resources
  has_many    :invites
  has_many    :bills, -> { order 'created_at desc' }
  has_many    :newsitems
  validates   :name, :token, presence: true #:street, :city, :zip,
  validates   :name, uniqueness: { case_sensitive: false }
  # geocoded_by :full_street_address
  # after_validation :geocode

  def add_user(user)
    user.flat = self
    user.save!
  end

  def full_street_address
    if !zip.nil? && !city.nil? && !street.nil?
      zip + ' ' + city + ', ' + street
    else
      ''
    end
  end

  def is_member?(user)
    users.any? { |u| u.id == user.id }
  end

  def self.create_with_user!(user, params)
    nf = Flat.new(params)
    nf.save!
    nf.add_user(user)
    nf
  end

  def self.find_by_token(token)
    find_by token: token
  end
end
