json.array!(@courses) do |course|
  json.extract! course, :id, :code, :title, :details, :credit_hours, :semester, :instructor, :user_id
  json.url course_url(course, format: :json)
end
