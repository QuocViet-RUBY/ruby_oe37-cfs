class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum spending_category: {income: 0, expenses: 1}
  enum type_money: {fixed: 0, incurred: 1}
  enum status: {confirm: 0, unconfirm: 1}

  validates :moneys, numericality: {greater_than_or_equal_to: 10000}, presence: true

  def self.spending_category_option
    spending_categories.map{|key, _value| [key.capitalize, key]}
  end

  def self.type_option
    type_moneys.map{|key, _value| [key.capitalize, key]}
  end

  def self.status_option
    statuses.map{|key, _value| [key.capitalize, key]}
  end
end
