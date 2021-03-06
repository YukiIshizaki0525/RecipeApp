# == Schema Information
#
# Table name: consulation_comments
#
#  id             :bigint           not null, primary key
#  content        :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  consulation_id :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_consulation_comments_on_consulation_id  (consulation_id)
#  index_consulation_comments_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (consulation_id => consultations.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :consulation_comment do
    content { "MyText" }
    user { nil }
    consulation { nil }
  end
end