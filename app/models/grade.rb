class Grade < ApplicationRecord
  has_many :classrooms

  default_scope { where(school_id: CurrentUser.first&.current_user).order('index_sorting desc', 'created_at desc ') }

  def self.names
    Grade.all.collect do |g|
      {value: g.name}
    end
  end
end
