class Account < ActiveRecord::Base
    self.table_name = 'account'

    validates_uniqueness_of :code
    validates :code, presence: true
    validates :codecs, :presence => { :message => "Select a codec" }

    belongs_to :customer
    has_many :account_codecs
    has_many :codecs, :through => :account_codecs
    belongs_to :admin
end
