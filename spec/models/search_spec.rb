require 'rails_helper'

RSpec.describe Search, type: :model do
  it { should validate_presence_of :url }

  let!(:search) { create(:search) }

  describe 'Адрес запроса должен начиться с "https://github.com"' do
    it 'Правильный адрес' do
      expect(Search.create(attributes_for(:other_search)).errors.blank?).to be_truthy
    end

    it 'Неправильный адрес' do
      expect(Search.create(attributes_for(:invalid_url_search)).errors.messages).to eq(url: ['должен начинаться с "https://github.com"'])
    end
  end

  describe 'Перед сохранением нового запроса, старый должен удалиться' do
    it 'В БД всегда храниться не более одного запроса' do
      Search.create(attributes_for(:other_search))
      expect(Search.count).to eq 1
    end

    it 'В БД всегда храниться последний запрос' do
      new_search = Search.create(attributes_for(:other_search))
      expect(Search.first).to eq new_search
    end
  end

  describe '#repository' do
    it 'Получение репозитория из адреса' do
      expect(search.repository).to eq 'rails/rails'
    end
  end

  describe 'Запрос контрибьюторов по адресу после сохранения запроса' do
    it 'В БД сохраняется три лучших контрибьюторов' do
      Search.create(attributes_for(:other_search))
      expect(Search.first.contributors.count).to eq 3
    end
  end
end
