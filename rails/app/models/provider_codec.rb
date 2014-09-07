class ProviderCodec < ActiveRecord::Base
    self.table_name = 'provider_codec'


    belongs_to :provider, :class_name => 'Provider', :foreign_key => :provider_id
    belongs_to :codec, :class_name => 'Codec', :foreign_key => :codec_id
end
