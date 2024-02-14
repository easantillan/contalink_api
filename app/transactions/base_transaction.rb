class Transactions::BaseTransaction
  include Dry::Transaction

  def self.call(*args, &block)
    new.call(*args, &block)
  end
end