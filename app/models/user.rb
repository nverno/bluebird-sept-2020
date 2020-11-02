# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  age                   :integer          not null
#  political_affiliation :string
#  password_digest       :string           not null
#  session_token         :string           not null
#
class User < ApplicationRecord 
    validates :username, :age, presence: true 
    validates :username, uniqueness: true

    validates :session_token, :password_digest, presence: true
    validates :session_token, uniqueness: true

    validates :password, length: { minimum: 6 }, allow_nil: true

    attr_reader :password

    # after we call User.new()
    after_initialize :ensure_session_token

    # right before User.save
    #before_validation :ensure_session_token

    # associations
    has_many :chirps, # what you want to name association
        primary_key: :id, # from this class
        foreign_key: :author_id, # from other class
        class_name: :Chirp # other class
    
    has_many :likes,
        primary_key: :id,
        foreign_key: :liker_id,
        class_name: :Like 
    
    has_many :liked_chirps,
        through: :likes, # must be association name from this class!!
        source: :chirp # must be association name!!

    # User Auth Methods (SPIRE)

    def self.find_by_credentials(username, password)
      user = User.find_by(username: username)

      if user && user.is_password?(password)
        user
      else
        nil
      end
    end

    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def reset_session_token!
      self.session_token = SecureRandom::urlsafe_base64
      self.save!
      self.session_token
    end

    def ensure_session_token
      self.session_token ||= SecureRandom::urlsafe_base64
    end


    #* User Queries:
    ## The following queries are being typed here mainly as a resource for you.
    
    #? Find all instructors between the ages of 90 to 100 inclusive

    # User.find_by # only one object returned
    User.where("age BETWEEN 90 AND 100") # inclusive
    User.where(age: 90..100) # inclusive

    #? Find all users that are not JavaScript affiliated (use where not)

    User.where.not("political_affiliation = 'JavaScript'")

    #? Find all instructors in this list and order by ascending
    instructors = ["mish_mosh", "wakka_wakka", "jen_ken_intensifies"]

    # User.where.in(["mish_mosh", "wakka_wakka", "jen_ken_intensifies"]).order("username")
    User.where("username IN (?)", instructors).order("username")
    User.where(username: instructors).order("username") # Rails MAGIC
    
end
