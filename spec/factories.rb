FactoryGirl.define do
  factory :user do
    epost "notinuse@tictactoivo.com"
    password 'foobar'
    username "notinuse"
    admin false
  end
  factory :admin, class: User do
    epost "admin@tictactoivo.com"
    password 'hidden'
    usename 'Admin'
    admin true
  end
end
