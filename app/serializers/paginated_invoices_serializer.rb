class PaginatedInvoicesSerializer < ActiveModel::Serializer
  attributes :invoices, :pagination

  def invoices
    ActiveModel::Serializer::CollectionSerializer.new(object[:invoices], each_serializer: InvoiceSerializer)
  end

  def pagination
    object[:pagination]
  end

  def serializable_hash(adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance)
    hash = super
    hash.deep_transform_keys! { |key| key.to_s.camelize(:lower) }
  end
end