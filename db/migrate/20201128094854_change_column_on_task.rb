class ChangeColumnOnTask < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :deadline, false
    change_column_default :tasks, :deadline, from: "now()", to: "2020-02-02 00:00:00"
  end
end
