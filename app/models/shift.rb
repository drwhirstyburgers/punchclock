class Shift < ApplicationRecord
  belongs_to :teacher

  default_scope { order('created_at DESC') }
end
