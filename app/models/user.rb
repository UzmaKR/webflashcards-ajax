class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :uniqueness => true
  validates :email, :presence => true
  validates :password, :length => { :in => 6..20 }, :confirmation => true
  validates :password_confirmation, :presence => true

  attr_accessor :password

  before_create :encrypt_password

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    fresh_encryption = Digest::SHA1.hexdigest("#{password}#{user.salt}")
    user.encrypted_password == fresh_encryption ? user : nil
  end

private

  def encrypt_password
    self.salt = Digest::SHA1.hexdigest("#{self.email}#{Time.now}")
    self.encrypted_password = Digest::SHA1.hexdigest("#{self.password}#{self.salt}")
    self.password = nil
  end
end
