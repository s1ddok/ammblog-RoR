include ActionView::Helpers::DateHelper

class Post < ActiveRecord::Base
  default_scope { order('created_at desc') }

  belongs_to :user, -> { select(:id,
  	:username
  )}

  validates :text, presence: true, length: { minimum: 3, maximum: 300 }

  def when
    time_ago_in_words created_at
  end

  def self.all_by_username(username)
    joins(:user).where(users: { username: username } )
  end

end
