class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  
  validates :name, presence: true
  validates :introduction, length:{ maximum: 100 }
  
  has_one_attached :group_image
  
  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_group.jpg')
      group_image.attach(io: File.open(file_path), filename: 'no_group.jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end
end
