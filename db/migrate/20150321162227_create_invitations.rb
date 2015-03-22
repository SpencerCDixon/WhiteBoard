class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :invite_token
      t.datetime :created_at
      t.datetime :sent_at
      t.datetime :accepted_at
      t.integer :sender_id, null: false
      t.integer :family_id, null: false
      t.string :status, default: "pending"
      t.string :email, null: false
      t.string :name, null: false
    end
    add_index :invitations, :invite_token, unique: true
  end
end
