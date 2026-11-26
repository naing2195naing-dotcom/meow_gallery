
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one_attached :profile_image

  validates :name, presence: true
  validates :email_address,
            presence: true,
            uniqueness: { message: "は既に登録されています。" }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validate :acceptable_profile_image

  private

  def acceptable_profile_image
    return unless profile_image.attached?

    unless profile_image.content_type.in?(%w[image/jpeg image/png image/webp])
      errors.add(:profile_image, "はJPEG、PNG、WebP形式のみ使用できます。")
    end

    if profile_image.byte_size > 5.megabytes
      errors.add(:profile_image, "は5MB以下にしてください。")
    end
  end
end
