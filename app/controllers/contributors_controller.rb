require 'zip'
class ContributorsController < ApplicationController
  before_action :load_contributors, only: :index
  before_action :load_contributor, only: :show

  def index
    respond_to do |format|
      format.zip do
        compressed_filestream = Zip::OutputStream.write_buffer do |zos|
          @contributors.each do |contributor|
            pdf = ContributorPdf.new(contributor)
            zos.put_next_entry "contributor-#{contributor.position}.pdf"
            zos.print pdf.render
          end
        end

        compressed_filestream.rewind
        send_data compressed_filestream.read, filename: "contributors.zip"
      end
    end
  end

  def show
    respond_to do |format|
      format.pdf do
        pdf = ContributorPdf.new(@contributor)
        send_data pdf.render, filename: 'contributor.pdf', type: 'application/pdf'
      end
    end
  end

  private

  def load_contributors
    @contributors = Contributor.all
  end

  def load_contributor
    @contributor = Contributor.find(params[:id])
  end
end
