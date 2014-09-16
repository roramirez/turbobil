class Provider < ActiveRecord::Base
    self.table_name = 'provider'

    validates :name, presence: true
    validates :codecs, :presence => { :message => "Select a codec" }

    has_many :calls
    has_many :rates
    has_many :provider_codecs
    has_many :codecs, :through => :provider_codecs
    belongs_to :admin
    belongs_to :protocol
end
