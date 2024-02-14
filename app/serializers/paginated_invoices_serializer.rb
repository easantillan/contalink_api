class PaginatedInvoicesSerializer < ActiveModel::Serializer
  attributes :invoices, :pagination

  def invoices
    ActiveModel::Serializer::CollectionSerializer.new(object[:invoices], each_serializer: InvoiceSerializer)
  end

  def pagination
    object[:pagination]
  end
end