class CreateDatabase < ActiveRecord::Migration
  def up

    create_table :account, force: true do |t|
      t.text :code
      t.references :admin
      t.references :customer
      t.integer :status
      t.text :ip_auth
      t.text :password
    end

    create_table :account_codec, force: true do |t|
      t.references :account
      t.references :codec
    end

    create_table :admin, force: true do |t|
      t.text :name
      t.string :email, null: false, :limit => 320
    end

    create_table :call, force: true do |t|
      t.references :admin
      t.references :customer
      t.datetime :at
      t.integer :duration
      t.references :provider
      t.references :route
      t.float :cost
      t.text :destination
      t.text :ip
      t.text :hangupcause
      t.references :price_customer
      t.references :currency
      t.text :dialstatus
    end

    create_table :codec, force: true do |t|
      t.text :name
      t.text :code
    end

    create_table :currency, force: true do |t|
      t.text :sign
      t.text :name
      t.text :code
      t.float :value_convert
    end

    create_table :customer, force: true do |t|
      t.text :name
      t.string :email, null: false, :limit => 320
      t.float :credit
      t.integer :type_pay
      t.references :customer
      t.references :type_customer
      t.references :admin
      t.references :currency
    end

    create_table :price_customer, force: true do |t|
      t.text :name
      t.float :percent_recharge
      t.references :admin
    end

    create_table :protocol, force: true do |t|
      t.text :name
    end

    create_table :provider, force: true do |t|
      t.text :name
      t.text :email
      t.references :admin
      t.float :balance
      t.integer :priority
      t.integer :status
      t.text :from_user
      t.text :host
      t.text :username
      t.text :password
      t.references :protocol
    end

    create_table :provider_codec, force: true do |t|
      t.references :provider
      t.references :codec
      t.integer :priority
    end

    create_table :rate, force: true do |t|
      t.references :provider
      t.references :route
      t.integer :priority
    end

    create_table :rate_customer, force: true do |t|
      t.references :route
      t.float :value
      t.references :price_customer
    end

    create_table :route, force: true do |t|
      t.text :prefix
      t.text :name
      t.references :admin
    end

    create_table :type_customer, force: true do |t|
      t.text :name
      t.references :admin
    end
  end

end
