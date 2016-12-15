class Restaurant < ActiveRecord::Base
  validates :name, presence: true

  def self.search(r_id: nil, name: nil)
  	with_r_id(r_id)
  		.with_name(name)
  end

  scope :with_r_id, proc { |r_id|
  	if r_id.present?
  		where(r_id: r_id)
  	end
  }

  scope :with_name, proc { |name|
  	if name.present?
  		where(name: name)
  	end
  }
end
