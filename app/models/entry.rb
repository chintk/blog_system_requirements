class Entry < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true

# Returns a entry's comments.
  def comments(entry_id)
    Comment.where("entry_id = :entry_id", entry_id: entry_id)
  end
end
