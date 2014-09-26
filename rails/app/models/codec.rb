class Codec < ActiveRecord::Base
  self.table_name = 'codec'

  has_many :account_codecs
  has_many :provider_codecs
  has_many :accounts, :through => :account_codecs
  has_many :provider, :through => :provider_codecs
end
