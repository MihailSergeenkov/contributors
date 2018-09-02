require 'rails_helper'

RSpec.describe ContributorsController, type: :controller do
  let!(:search) { create(:search) }
  let!(:contributors) { search.contributors }
  let!(:contributor) { contributors.first }

  describe 'GET #index' do
    before { get :index, format: :zip }

    it 'Переменная @contributors содержит контрибьюторов' do
      expect(assigns(:contributors)).to match_array(contributors)
    end

    it 'Возврат статус - success' do
      expect(response).to have_http_status :success
    end
  end

  describe 'GET #show' do
    before { get :show, format: :pdf, params: { id: contributor.id } }

    it 'Переменная @contributor содержит контрибьютора' do
      expect(assigns(:contributor)).to eq contributor
    end

    it 'Возврат статус - success' do
      expect(response).to have_http_status :success
    end
  end
end
