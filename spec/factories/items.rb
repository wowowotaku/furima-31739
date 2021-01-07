FactoryBot.define do
  factory :item do

    item_name      {'neko'}
    category_id    {'2'}
    explain        {'ねこです'}
    price          {'300'}
    status_id      {'2'}
    shippingfee_id {'2'}
    from_id        {'2'}
    day_id         {'2'}
    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
