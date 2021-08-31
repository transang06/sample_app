class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope ->{order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content_max_length}
  validates :image,
            content_type: {in: %w(image/jpeg image/gif image/png),
                           message: :format},
            size: {less_than: Settings.micropost.file_size.megabytes,
                   message: :less_than}

  def display_image
    image.variant(resize_to_limit:
      [Settings.micropost.resize_w, Settings.micropost.resize_h])
  end
end
