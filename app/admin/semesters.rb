ActiveAdmin.register Semester do
  permit_params :name, :start_date, :end_date

  filter :title
  filter :start_date
  filter :end_date

  actions :all
end
