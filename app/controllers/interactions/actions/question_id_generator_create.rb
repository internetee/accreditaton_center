module Actions
	class QuestionIdGeneratorCreate
		def initialize(question_id:, user_answer:)
			@question_id = question_id
			@user_answer = user_answer
		end
		
		def call
			generate_id_for_new_question
		end

		private

		def generate_id_for_new_question
			question = Question.find(@question_id)
			category = question.category

			results = Question.where(category_id: category.id)

			actual_questions = results.reject { |r| @user_answer.question_ids.include? r.id }

			return false if actual_questions.nil?

			return false if actual_questions.size < 1

			actual_questions.first.id
		end
	end
end

