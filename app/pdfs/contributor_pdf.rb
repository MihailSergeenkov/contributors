class ContributorPdf < Prawn::Document
  attr_reader :contributor

  def initialize(contributor)
    super()
    @contributor = contributor
    text_content
  end

  def text_content
    font_families.update(
      'OpenSans' => {
        normal: "#{Rails::root}/app/assets/fonts/open-sans.ttf"
      }
    )

    header = "PDF ##{contributor.position}"
    y_position = cursor - 150
    text_box header, at: [200, y_position], size: 32

    font('OpenSans') do
      text = I18n.t('contributors.pdf_text')
      y_position -= 50
      text_box text, at: [150, y_position], size: 20
    end

    username = contributor.username
    y_position -= 50
    text_box username, at: [210, y_position], size: 16
  end
end
