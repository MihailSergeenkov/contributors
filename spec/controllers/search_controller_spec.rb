require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let!(:search) { create(:search) }

  describe 'GET #show' do
    before { get :show }

    it 'Переменная @search содержит последний запрос поиска' do
      expect(assigns(:search)).to eq search
    end

    it 'Переменная @new_search содержит новый запрос поиска' do
      expect(assigns(:new_search)).to be_a_new(Search)
    end

    it 'Генерация show шаблона' do
      expect(response).to render_template :show
    end

    it 'Возврат статус - success' do
      expect(response).to have_http_status :success
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'Переменная @new_search содержит новый запрос поиска' do
      expect(assigns(:new_search)).to be_a_new(Search)
    end

    it 'Генерация new шаблона' do
      expect(response).to render_template :new
    end

    it 'Возврат статус - success' do
      expect(response).to have_http_status :success
    end
  end

  describe 'POST #create' do
    context 'html запрос' do
      context 'С правильным атрибутом' do
        it 'Кол-во запросов не меняется' do
          expect { post :create, params: { search: attributes_for(:other_search) } }.to_not change(Search, :count)
        end

        it 'Сохранение нового запроса в БД' do
          attributes = attributes_for(:other_search)
          post :create, params: { search: attributes }
          expect(Search.first.url).to eq attributes[:url]
        end

        it 'Перенаправление на страницу с результатом запроса' do
          post :create, params: { search: attributes_for(:other_search) }
          expect(response).to redirect_to search_path
        end

        it 'Возврат статус - redirect' do
          post :create, params: { search: attributes_for(:other_search) }
          expect(response).to have_http_status :redirect
        end
      end

      context 'С неправильным атрибутом' do
        it 'Кол-во запросов не меняется' do
          expect { post :create, params: { search: attributes_for(:invalid_search) } }.to_not change(Search, :count)
        end

        it 'Новый запрос не сохраняется в БД' do
          post :create, params: { search: attributes_for(:invalid_search) }
          expect(Search.first.url).to eq search.url
        end

        it 'Перегенерация new шаблона' do
          post :create, params: { search: attributes_for(:invalid_search) }
          expect(response).to render_template :new
        end

        it 'Возврат статус - success' do
          post :create, params: { search: attributes_for(:invalid_search) }
          expect(response).to have_http_status :success
        end
      end
    end

    context 'js запрос' do
      context 'С правильным атрибутом' do
        it 'Кол-во запросов не меняется' do
          expect { post :create, format: :js, params: { search: attributes_for(:other_search) } }.to_not change(Search, :count)
        end

        it 'Сохранение нового запроса в БД' do
          attributes = attributes_for(:other_search)
          post :create, format: :js, params: { search: attributes }
          expect(Search.first.url).to eq attributes[:url]
        end

        it 'Генерация create шаблона' do
          post :create, format: :js, params: { search: attributes_for(:other_search) }
          expect(response).to render_template :create
        end

        it 'Возврат статус - success' do
          post :create, format: :js, params: { search: attributes_for(:other_search) }
          expect(response).to have_http_status :success
        end
      end

      context 'С неправильным атрибутом' do
        it 'Кол-во запросов не меняется' do
          expect { post :create, format: :js, params: { search: attributes_for(:invalid_search) } }.to_not change(Search, :count)
        end

        it 'Новый запрос не сохраняется в БД' do
          post :create, format: :js, params: { search: attributes_for(:invalid_search) }
          expect(Search.first.url).to eq search.url
        end

        it 'Генерация create шаблона' do
          post :create, format: :js, params: { search: attributes_for(:invalid_search) }
          expect(response).to render_template :create
        end

        it 'Возврат статус - success' do
          post :create, format: :js, params: { search: attributes_for(:invalid_search) }
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
