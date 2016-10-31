# frozen_string_literal: true
Sequel.migration do
  change do
    create_table(:application_table) do
      primary_key :id, auto_increment: true
      String :entry, text: true, null: false
      DateTime :created_at, null: false
    end
  end
end
