Sequel.migration do
  up do
    add_column :users, :roll, String
    self[:users].update(:roll=>'unknown')
  end

  down do
    drop_column :users, :roll
  end
end