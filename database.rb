require "sqlite3"

File.delete("quiz.db")
db = SQLite3::Database.new "quiz.db"

question = db.execute('
  create table questions (
    question text,
    answer text,
    type text,
    altern text
  );
  '
)

[
  ["Vad heter huvudstaden i Norge?", "oslo", "mono"],
  ["Hur många bilar i sverige?", "6.12345", "numeric"],
  ["A B eller C?", "A", "poly", "A B C"],
  ["Vilket år släpptes Ruby 1.0?", "1996", "mono"],
  ["Vad svarar 5.class?", "Integer", "mono"]
].each do |query|
  db.execute "insert into questions (question, answer, type, altern) values ( ?, ?, ?, ? )", query
end

p db

db.execute( "select * from questions" ) do |row|
  p row if row[2] != "poly"
  p row[3].split if row[2] == "poly"
end