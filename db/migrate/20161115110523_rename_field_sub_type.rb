class RenameFieldSubType < ActiveRecord::Migration[5.0]
  def change
    rename_column :cards, :subtype_list, :subtypes_list
  end
end
