module CustomerHelper
  def type_payment type
    case type
      when 1
        :prepay
      when 2
        :postpay
    end
  end
end
