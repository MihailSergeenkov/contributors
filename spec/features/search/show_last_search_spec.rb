require 'rails_helper'

feature 'Посмотреть старый запрос' do
  given!(:search) { create(:search) }

  scenario 'Пользователь может просмотреть старый запрос' do
    visit search_path

    expect(page).to have_content 'Результаты'
    expect(page).to have_content "Адрес: #{search.url}"

    expect(page).to have_content search.contributors.first.username
    expect(page).to have_content search.contributors.second.username
    expect(page).to have_content search.contributors.third.username
    expect(page).to have_content 'Загрузить ZIP (3)'
  end
end
