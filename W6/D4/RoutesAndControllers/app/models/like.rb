# == Schema Information
#
# Table name: likes
#
#  id           :bigint           not null, primary key
#  liker_id     :integer          not null
#  likable_id   :integer          not null
#  likable_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true

  belongs_to :liker,
    foreign_key: :liker_id,
    class_name: :User
end
