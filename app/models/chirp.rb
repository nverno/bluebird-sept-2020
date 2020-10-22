# == Schema Information
#
# Table name: chirps
#
#  id        :bigint           not null, primary key
#  body      :text             not null
#  author_id :integer          not null
#
class Chirp < ApplicationRecord 
    #validations run when you try to save
    validates :body, presence: true 
    # validates :author_id, presence: true  
    #belongs_to association automatically validates presence of author_id so no need to explicitly validate
    validate :body_too_long #custom validation, need to use validate singular

    #custom validation
    def body_too_long 
        #check if body exists first
        if body && body.length > 140
            errors[:body] << 'is too long. Keep it short please.'
        end
    end

    #associations
    #belongs_to if you hold a foreign key
    belongs_to :author, #what you want to name association
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User #'User' works as well
    #cannot do one-liner bc foreign key author_id isn't same as class name user

    has_many :likes,
        foreign_key: :chirp_id,
        class_name: :Like 
    
    has_many :likers,
        through: :likes,
        source: :liker 
end
