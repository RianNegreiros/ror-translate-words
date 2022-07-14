require 'rails_helper'

RSpec.describe WordsController, type: :controller do
  describe "GET /index" do
    before { get :index }

    context 'when some words are present' do
      let!(:word) { create(:word) }

      it 'assigns @words' do
        expect(assigns(:words)).to eq([word])
      end
      
      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when there is no words present' do
      it 'assigns @words' do
        expect(assigns(:words)).to eq([])
      end
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
end
