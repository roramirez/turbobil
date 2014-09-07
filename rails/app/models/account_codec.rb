class AccountCodec < ActiveRecord::Base
    self.table_name = 'account_codec'


    belongs_to :codec, :class_name => 'Codec', :foreign_key => :codec_id
    belongs_to :account, :class_name => 'Account', :foreign_key => :account_id
end
