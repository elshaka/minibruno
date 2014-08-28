class Stop < ActiveRecord::Base
  belongs_to :user

  def end
    update({ended_at: Time.now})
  end
end