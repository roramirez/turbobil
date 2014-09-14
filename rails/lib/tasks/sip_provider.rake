require 'inifile'
desc "create/update provider file for sip conf"

task :provider_sip => :environment do

  if ENV["ID"] == 'ALL'
    providers = Provider.all
  else
    providers = Provider.find(ENV["ID"])
  end

  providers.each do |provider|

    id = "#{provider.id}_provider"
    filename =  "#{Settings.turbobil['dir_sips']}#{provider.id}.provider"
    file = IniFile.new( :filename => filename, :encoding => 'UTF-8' )

    #authen by pass
    if provider.password.to_s != ''
      file[id]['secret']    = provider.password
    else
      file[id].delete('secret')
    end

    if provider.username.to_s != ''
      file[id]['username']  = provider.username
    else
      file[id].delete('username')
    end

    if provider.from_user.to_s != ''
      file[id]['fromuser']  = provider.from_user
    else
      file[id].delete('fromuser')
    end


    file[id]['host']      = provider.host
    file[id]['insecure']  = 'very'

    file[id]['canreinvite'] = 'no'
    file[id]['reinvite']    = 'no'

    file[id]['context']     = 'turbobil'
    file[id]['dtmfmode']    = 'rfc2833'
    file[id]['nat']         = 'yes'
    file[id]['qualify']     = 'yes'
    file[id]['type']        = 'peer'

    #Codecs
    file[id]['disallow']    =  'all'
    #IMPROVEME
    allow = ''
    i = 0
    provider.codecs.each do |codec|
      i += 1
      if i > 1
        allow += ','
      end
      allow += codec.code
    end

    file[id]['allow']    =  allow
    file.write
  end
  %x(sudo /usr/sbin/asterisk -rx 'sip reload')
end
