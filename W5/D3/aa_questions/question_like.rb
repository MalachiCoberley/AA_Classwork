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