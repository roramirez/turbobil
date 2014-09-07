class Provider < ActiveRecord::Base
    self.table_name = 'provider'

    validates :name, presence: true

    has_many :calls, :class_name => 'Call'
    has_many :rates, :class_name => 'Rate'
    has_many :provider_codecs, :class_name => 'ProviderCodec'
    has_many :codecs, :through => :provider_codecs
    belongs_to :admin, :class_name => 'Admin', :foreign_key => :admin_id
    belongs_to :protocol, :class_name => 'Protocol', :foreign_key => :protocol_id
end
