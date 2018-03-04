json.feedbacks @feedbacks do |feedback|
  json.ratable_id feedback.ratable_id
  json.ratable_type feedback.ratable_type
  json.rating feedback.rating
  json.comment feedback.comment
end

