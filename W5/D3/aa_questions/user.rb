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