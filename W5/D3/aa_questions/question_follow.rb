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