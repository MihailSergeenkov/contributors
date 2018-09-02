require 'rails_helper'

feature 'Новый запрос' do
  given!(:search) { create(:search) }
  given(:new_search) { build(:other_search) }

  describe 'Пользователь создает запрос со страницы нового запроса' do
    background { visit new_search_path }

    scenario 'С правильными данными' do
      fill_in 'search[url]', with: new_search.url
      click_on 'Искать'

      expect(current_path).to eq search_path
      expect(page).to have_content 'Результаты'
      expect(page).to have_content "Адрес: #{new_search.url}"

      expect(page).to have_content Search.last.contributors.first.username
      expect(page).to have_content Search.last.contributors.second.username
      expect(page).to have_content Search.last.contributors.third.username
      expect(page).to have_content 'Загрузить ZIP (3)'
    end

    scenario 'С неправильными данными' do
      fill_in 'search[url]', with: nil
      click_on 'Искать'

      expect(page).to have_content 'Невозможно выполнить запрос!'
    end
  end

  describe 'Пользователь создает запрос со страницы старого запроса' do
    background do
      visit search_path

      expect(page).to have_content 'Результаты'
      expect(page).to have_content "Адрес: #{search.url}"
    end

    scenario 'С правильными данными', js: true do
      fill_in 'search[url]', with: new_search.url
      click_on 'Искать'

      expect(current_path).to eq search_path
      expect(page).to have_content 'Результаты'
      expect(page).to_not have_content "Адрес: #{search.url}"
      expect(page).to have_content "Адрес: #{new_search.url}"

      expect(page).to have_content Search.last.contributors.first.username
      expect(page).to have_content Search.last.contributors.second.username
      expect(page).to have_content Search.last.contributors.third.username
      expect(page).to have_content 'Загрузить ZIP (3)'
    end

    scenario 'С неправильными данными', js: true do
      fill_in 'search[url]', with: nil
      click_on 'Искать'

      expect(current_path).to eq search_path
      expect(page).to have_content "Адрес: #{search.url}"
      expect(page).to have_content 'Адрес не может быть пустым!'
    end
  end
end
