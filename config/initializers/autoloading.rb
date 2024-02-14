
module Transactions; end

Rails.autoloaders.main.push_dir("#{Rails.root}/app/transactions", namespace: Transactions)