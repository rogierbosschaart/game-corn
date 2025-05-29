class AddAcceptedToOffer < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :accepted, :boolean
  end
end
