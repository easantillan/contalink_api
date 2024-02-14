class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :invoice_number, :total, :invoice_date, :status

  def invoice_date
    object.invoice_date.strftime("%m/%d/%Y %I:%M %p")
  end
end
