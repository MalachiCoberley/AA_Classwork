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