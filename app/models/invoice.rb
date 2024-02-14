# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  invoice_number :string
#  total          :decimal(, )
#  invoice_date   :datetime
#  status         :string
#
class Invoice < ApplicationRecord
end
