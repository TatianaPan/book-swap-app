class SetRussianCollationOnBooks < ActiveRecord::Migration[6.0]
  def up
    execute 'ALTER TABLE books ALTER COLUMN author TYPE varchar COLLATE "ru_RU.UTF-8";'
    execute 'ALTER TABLE books ALTER COLUMN title TYPE varchar COLLATE "ru_RU.UTF-8";'
  end
end
