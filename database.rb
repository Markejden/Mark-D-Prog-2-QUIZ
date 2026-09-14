require "sqlite3"

File.delete("quiz.db")
db = SQLite3::Database.new "quiz.db"

question = db.execute <<-SQL
  create table questions (
    name varchar(30),
    val int
  );
SQL

{
  "Vad heter huvudstaden i Norge?" => "oslo",
  "Vilket år släpptes Ruby 1.0?" => "1996",
  "Vad svarar 5.class?" => "Integer",
}.each do |pair|
  db.execute "insert into questions values ( ?, ? )", pair
end

db.execute( "select * from questions" ) do |row|
  p row
end