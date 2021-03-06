# == Schema Information
#
# Table name: recipes
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  image       :string(255)
#  title       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :recipe, class: Recipe do
    title { 'テストタイトル' }
    description { 'テストディスクリプション' }
    image { File.open("#{Rails.root}/spec/fixtures/salad.jpg") }

    trait :with_ingredients do
      after(:build) do |recipe|
        ingredient = build(:ingredients)
        recipe.ingredients << ingredient
      end
    end

    trait :with_steps do
      after(:build) do |recipe|
        step = build(:steps)
        recipe.steps << step
      end
    end

    factory :other_recipe do
      title { 'テストタイトル2' }
      description { 'テストディスクリプション2' }
    end
  end
end
