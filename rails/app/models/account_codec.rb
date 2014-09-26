class AccountCodec < ActiveRecord::Base
  self.table_name = 'account_codec'

  belongs_to :codec
  belongs_to :account
end
