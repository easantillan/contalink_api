class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :invoice_number, :total, :invoice_date, :status

  # To avoid decimal value is parsed to
  # a string in the JSON response
  def total
    object.total.to_f
  end

  def invoice_date
    object.invoice_date.strftime("%d/%m/%Y %I:%M %p")
  end

  def serializable_hash(adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance)
    hash = super
    hash.deep_transform_keys! { |key| key.to_s.camelize(:lower) }
  end
end
