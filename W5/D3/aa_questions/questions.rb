require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :id, :fname, :lname

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ?
    AND
      lname = ?
    SQL

    User.new(user.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    #this will use Question::find_by_author_id

    Question.find_by_author_id(self.id)
  end

  def authored_replies
    #this will use Reply::find_by_user_id

    Reply.find_by_user_id(self.id)
  end

  def self.followed_questions
    #oneliner calling QuestionFollow method
  end

end

#Start of Question Class ------------------------------------------

class Question
  attr_accessor :id, :title, :body, :user_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL

    Question.new(question.first)
  end

  def self.find_by_author_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
     *
    FROM
      questions
    WHERE
      user_id = ?
    SQL
    questions.map {|question| Question.new(question)}
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    user = QuestionsDatabase.instance.execute(<<-SQL, self.user_id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
    User.new(user.first)
  end

  def replies
    #use Reply::find_by_question_id
    Reply.find_by_question_id(self.id)
  end

  def followers
    #one-line calling QuestionFolow method
  end

end


#Start of Reply Class ------------------------------------------

class Reply
  attr_accessor :id, :subject_question_id, :reply_to_id, :user_id, :body

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    Reply.new(reply.first)
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      subject_question_id = ?
    SQL

    replies.map { |reply| Reply.new(reply)}
  end

  def initialize(options)
    @id = options['id']
    @subject_question_id = options['subject_question_id']
    @reply_to_id = options['reply_to_id']
    @user_id = options['user_id']
    @body = options['body']

  end

  def author
    user = QuestionsDatabase.instance.execute(<<-SQL, self.user_id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
    User.new(user.first)
  end

  def question
    question = QuestionsDatabase.instance.execute(<<-SQL, self.subject_question_id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    Question.new(question.first)
  end

  def parent_reply
    reply = QuestionsDatabase.instance.execute(<<-SQL, self.reply_to_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    Reply.new(reply.first)
  end

  def child_replies
    # Only do child replies one-deep; don't find grandchild comments.
    replies = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply_to_id = ? 
    SQL
    replies.map { |reply| Reply.new(reply)}
  end

end

class QuestionFollow

  def self.followers_for_question_id(question_id)
    #this will return an array of User objects
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users 
      JOIN
        question_follows
      ON
        user_id = users.id 
      WHERE
        question_id = ?
    SQL
    followers.map {|follower| User.new(follower)}
  end

  def self.followed_questions_for_user_id(user_id)
    #returns an array of question objects
    QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SQL
  end



 
end