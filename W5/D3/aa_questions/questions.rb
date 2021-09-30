require 'sqlite3'
require 'singleton'
require 'user'
require 'question'
require 'reply'
require 'question_follow'
require 'question_like'

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
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    #oneliner calling QuestionFollow method
    QuestionFollow.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

  def average_karma
    avg_karma_arr = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT 
      CAST(COUNT(question_likes.user_id) AS FLOAT) / COUNT(DISTINCT(questions.id))  
    FROM 
      questions 
    LEFT JOIN 
      question_likes 
    ON 
      questions.id = question_likes.question_id 
    WHERE questions.user_id = ?
    SQL

    avg_karma_arr.first.values.first
  end

  def save
    raise "#{self} already in database" if self.id
    QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname)
    INSERT INTO
      users(fname, lname)
    VALUES
      (?, ?)    
    SQL
    self.id = QuestionsDatabase.instance.last_insert_row_id
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

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
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
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollow.followers_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_questions_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

  def save
    raise "#{self} already in database" if self.id
    QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.user_id)
    INSERT INTO
      questions(title, body, user_id)
    VALUES
      (?, ?, ?)    
    SQL
    self.id = QuestionsDatabase.instance.last_insert_row_id
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

  def save
    raise "#{self} already in database" if self.id
    QuestionsDatabase.instance.execute(<<-SQL, self.subject_question_id, self.reply_to_id, self.user_id, self.body)
    INSERT INTO
      replies(subject_question_id, reply_to_id, user_id, body)
    VALUES
      (?, ?, ?, ?)    
    SQL
    self.id = QuestionsDatabase.instance.last_insert_row_id
  end

end

# QuestionFollows class-------------------------------------------------

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
        users.id = user_id
      WHERE
        question_id = ?
    SQL
    followers.map {|follower| User.new(follower)}
  end

  def self.followed_questions_for_user_id(user_id)
    #returns an array of question objects
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_follows
    ON
      questions.id = question_id
    WHERE
      question_follows.user_id = ?
    SQL
    questions.map {|question| Question.new(question)}
  end

  def self.most_followed_questions(n)
    # Fetches the n most followed questions.
    questions = QuestionsDatabase.instance.execute(<<-SQL,n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows
      ON
        questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
    questions.map { |question| Question.new(question) }
  end
 
end


# QuestionLike class-------------------------------------------------

class QuestionLike

  def self.likers_for_questions_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      users
    JOIN
      question_likes
    ON
      users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?
    SQL
    users.map {|user| User.new(user)}
  end

  def self.num_likes_for_question_id(question_id)
    # dont just use question liker for question ID and count, do a SQL query
    count_hash_arr = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(*)
    FROM
      question_likes
    WHERE
      question_id = ?
    SQL
    count_hash_arr.first["COUNT(*)"]
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_likes
    ON
      questions.id = question_likes.question_id
    WHERE
      question_likes.user_id = ?
    SQL
    questions.map { |question| Question.new(question)}
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_likes
    ON
      questions.id = question_likes.question_id
    GROUP BY
      question_likes.question_id
    ORDER BY
      COUNT(question_likes.question_id) DESC
    LIMIT
      ?
    SQL
    questions.map { |question| Question.new(question)}
  end

end