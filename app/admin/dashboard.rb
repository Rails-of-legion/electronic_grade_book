ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
      panel "Generate Individual Report" do
        render 'admin/dashboard/generate_report_form'
      end
    end

  page_action :generate_report, method: :post do
    intermediate_attestation_id = params[:intermediate_attestation_id]
    record_book_id = params[:record_book_id]
  
    pdf_data = IndividualReport.generate_pdf(intermediate_attestation_id, record_book_id)
  
    send_data pdf_data, filename: "individual_report.pdf", type: "application/pdf"
  end
end
