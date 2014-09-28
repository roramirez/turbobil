require 'inifile'
desc "create/update account file for sip conf"

task :account_sip => :environment do

  if ENV["ID"] == 'ALL'
    accounts = Account.all
  else
    accounts = Account.find(ENV["ID"])
  end

  accounts.each do |account|
    filename =  "#{Settings.turbobil['dir_sips']}#{account.code}.account"
    file = IniFile.new( :filename => filename, :encoding => 'UTF-8' )

    file[account.code]['accountcode'] = account.code
    #authen by pass
    if account.password.to_s != ''
      file[account.code]['username']  = account.code
      file[account.code]['secret']    = account.password
    else
      file[account.code].delete('username')
      file[account.code].delete('secret')
    end

    #authen by ip
    if account.ip_auth.to_s == ''
      file[account.code]['host']      = 'dynamic'
      file[account.code]['insecure']  = 'port,invite'
    else
      file[account.code]['host']      = account.ip_auth
      file[account.code]['insecure']  = 'port,invite'
      file[account.code]['insecure']  = 'very'
    end

    file[account.code]['canreinvite'] = 'no'
    file[account.code]['context']     = 'turbobil'
    file[account.code]['reinvite']    = 'no'
    file[account.code]['dtmfmode']    = 'rfc2833'
    file[account.code]['nat']         = 'yes'
    file[account.code]['qualify']     = 'yes'
    file[account.code]['type']        = 'friend'

    #Codecs
    file[account.code]['disallow']    =  'all'

    #IMPROVEME
    allow = ''
    i = 0
    account.codecs.each do |codec|
      i += 1
      if i > 1
        allow += ','
      end
      allow += codec.code
    end

    file[account.code]['allow']    =  allow
    file.write
  end
  %x(sudo /usr/sbin/asterisk -rx 'sip reload')
end
