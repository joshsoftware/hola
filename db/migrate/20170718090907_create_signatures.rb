class CreateSignatures < ActiveRecord::Migration[5.0]
  def change
    create_table :signatures do |t|
      t.string 'name'
      t.string 'email'
      t.string 'smtp_mail_server'
      t.string 'port'
      t.string 'user_name'
      t.string 'password'
      t.timestamps
    end
  end
end
