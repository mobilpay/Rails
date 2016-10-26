

class OrderUrl
	include XML::Mapping

	text_node :return, "return"
	text_node :confirm, "confirm"
end


class Param
	include XML::Mapping

	text_node :name, "name"
	text_node :value, "value"
end

class Address
	include XML::Mapping

	text_node :type, "@type"

	text_node :first_name, "first_name", :default_value=>nil
	text_node :last_name, "last_name", :default_value=>nil
	text_node :address, "address", :default_value=>nil
	text_node :email, "email", :default_value=>nil
	text_node :mobile_phone, "mobile_phone", :default_value=>nil

end

class ContactInfo
	include XML::Mapping

	object_node :billing, "billing", :class=>Address, :default_value=>nil
	object_node :shipping, "shipping", :class=>Address, :default_value=>nil
end

class Invoice
  include XML::Mapping

  numeric_node :amount, "@amount", :default_value=>0
  text_node :currency, "@currency", :default_value=>nil
  text_node :details, "details",  :default_value=>""
  object_node :contact_info, "contact_info", :class=>ContactInfo, :default_value=>nil
end

class MobilpayError
	include XML::Mapping

	text_node :code, "@code", :default_value=>nil
end	

class MobilpayResponse
	include XML::Mapping

	text_node :timestamp, "@timestamp",:default_value=>Time.now.strftime("%Y%m%d%H%M%S")
	text_node :crc, "@crc",:default_value=>nil
	text_node :action, "action", :default_value=>nil
	object_node :customer, "customer", :class=>Address, :default_value=>nil
	text_node :purchase, "purchase",:default_value=>nil
	numeric_node :original_amount, "original_amount",:default_value=>nil
	numeric_node :processed_amount, "processed_amount",:default_value=>nil
	numeric_node :current_payment_count, "current_payment_count",:default_value=>nil
	text_node :pan_masked, "pan_masked",:default_value=>nil
	numeric_node :payment_instrument_id, "payment_instrument_id",:default_value=>nil
	object_node :error, "error",:class=>MobilpayError,:default_value=>nil
end


class Order
	include XML::Mapping

	text_node :type, "@type", :default_value=>nil
	text_node :timestamp, "@timestamp", :default_value=>Time.now
	text_node :id, "@id", :default_value=>nil

	text_node :signature, "signature", :default_value=>nil
	text_node :service, "service",:default_value=>nil
	object_node :invoice, "invoice", :class=>Invoice, :default_value=>nil
	array_node :params, "params", "param", :class=>Param, :default_value=>[]
	object_node :url, "url", :class=>OrderUrl, :default_value=>nil
	object_node :mobilpay, "mobilpay",:class=>MobilpayResponse, :default_value=>nil

end



