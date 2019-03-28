# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'securerandom'

class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  def self.random_code
    code = SecureRandom::urlsafe_base64

    if self.exists?(:short_url => code)
      code = SecureRandom::urlsafe_base64
    end

    code
  end

  def self.create_short(user, long_url)
    short = ShortenedUrl.random_code
    (ShortenedUrl.create!(long_url: long_url,short_url: short, user_id: user.id))

  end

    belongs_to :submitter, #whomever submitted the url will be traced with this association
    primary_key: :id, #INVERSE to submitted_urls associations
    foreign_key: :user_id,
    class_name: :User



  end

