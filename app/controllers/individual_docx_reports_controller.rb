require 'caracal'

class IndividualDocxReportsController < ApplicationController
  def generate_individual_report
    #@intermediate_attestation = IntermediateAttestation.find(params[:intermediate_attestation_id])
    docx_file = generate_individual_report_docx 

    send_file docx_file, filename: 'interim_report.docx', disposition: 'attachment'
  end

  private

  def generate_individual_report_docx
    temp_file = Tempfile.new(['interim_report', '.docx'])

    Caracal::Document.save(temp_file.path) do |docx|

      docx.p 'Учреждение образования', align: 'center', bold: true
      docx.p 'РЕСПУБЛИКАНСКИЙ ИНСТИТУТ ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ', align: 'center', bold: true

      docx.p "ЗАЧЕТНО-ЭКЗАМЕНАЦИОННАЯ ВЕДОМОСТЬ №", align: 'center', bold: true
      

      
      table_grades = [['10','','9','','8','','7',''],
                      ['6','','5','','4','','3',''],
                      ['2','','1','','','','',''],
                      ['зачтено','','не зачтено','']]
 
      docx.table table_grades, border_size: 8 do
        cell_style rows[0]
      end

     
      docx.p "Декан факультета", align: 'left'
      docx.p "повышения квалификации и", align: 'left'
      
    end

    temp_file.close
    temp_file.path
  end
end
