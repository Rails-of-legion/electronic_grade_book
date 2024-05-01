prawn_document title: 'User Report' do |pdf|
  pdf.text "Name: #{@user.name}"
  pdf.text "Email: #{@user.email}"
  pdf.text "Phone Number: #{@user.phone_number}"
  pdf.text "Date of Birth: #{@user.date_of_birth}"
  pdf.text "Roles: #{@user.roles.map(&:name).join(', ')}"

  if @user.roles.include? Role.find_by(name: 'teacher')
    pdf.start_new_page
    pdf.text "Teacher Reports"
    pdf.text "Subjects Taught: #{@user.subjects.map(&:name).join(', ')}"
  end

  if @user.roles.include? Role.find_by(name: 'student')
    pdf.start_new_page
    pdf.text "Student Reports"
    pdf.text "Attendances: #{@user.attendances.map { |a| "#{a.date}: #{a.attendance_status}" }.join("\n")}"
  end
end
