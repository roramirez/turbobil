class Account < ActiveRecord::Base
    self.table_name = 'account'

    validates_uniqueness_of :code
    validates :code, presence: true

    belongs_to :customer, :class_name => 'Customer', :foreign_key => :customer_id
    has_many :account_codecs, :class_name => 'AccountCodec'
    has_many :codecs, :through => :account_codecs
    belongs_to :admin, :class_name => 'Admin', :foreign_key => :admin_id
end
