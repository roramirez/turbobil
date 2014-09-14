namespace :sip do
  desc "rebuild all sips (provider and account)"
  task :rebuild_all_sip => :environment do
    controller = ApplicationController.new
    controller.call_rake :account_sip,  :id => 'ALL'
    controller.call_rake :provider_sip, :id => 'ALL'
  end
end
