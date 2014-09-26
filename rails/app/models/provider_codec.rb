class ProviderCodec < ActiveRecord::Base
  self.table_name = 'provider_codec'

  belongs_to :provider
  belongs_to :codec
end
