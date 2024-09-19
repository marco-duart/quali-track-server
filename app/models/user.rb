class User < ApplicationRecord
  enum role: { employee: 0, monitor: 1, manager: 2, admin: 3 }

  belongs_to :team, optional: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
