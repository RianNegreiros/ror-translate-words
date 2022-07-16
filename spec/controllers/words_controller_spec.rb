require 'rails_helper'

RSpec.describe WordsController, type: :controller do
  describe 'GET /index' do
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

  describe 'Get new' do
    before { get :new }

    it 'assigns @word' do
      expect(assigns(:word)).to be_a_new(Word)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'Post create' do
    subject { post :create, params: params }

    context 'valid params' do
      let!(:language) { create(:language) }
      let(:params) do
        { word: { value: 'any_value', language_id: language.id } }
      end

      it 'creates new word' do
        expect { subject }.to change(Word, :count).from(0).to(1)
      end
    end

    context 'invalid params' do
      let(:params) do
        { word: { value: nil } }
      end

      it 'does not create new word' do
        expect { subject }.not_to change(Word, :count)
      end
    end
  end

  describe 'Get show' do
    before { get :show, params: params }

    let(:params) do
      { id: word.id }
    end
    let!(:word) { create(:word) }

    it 'assigns @word' do
      expect(assigns(:word)).to eq(word)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET edit' do
    before { get :edit, params: params }

    let(:params) do
      { id: word.id }
    end
    let!(:word) { create(:word) }

    it 'assigns @word' do
      expect(assigns(:word)).to eq(word)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT update' do
    subject { put :update, params: params }

    let!(:language) { create(:language, name: 'English') }
    let!(:language_1) { create(:language, name: 'Spanish') }
    let!(:word) { create(:word, value: 'any_value', language: language) }

    context 'valid params' do
      let(:params) do
        { id: word.id, word: { value: 'updated_value', language_id: language_1.id } }
      end

      it 'update word' do
        expect { subject }.to change{ word.reload.value }.from('any_value').to('updated_value')
        .and change{ word.reload.language_id }.from(language.id).to(language_1.id)
      end
    end

    context 'invalid params' do
      let(:params) do
        { id: word.id, word: { value: nil } }
      end
      
      it 'does not update word' do
        expect { subject }.not_to change { word.reload.value }
      end
    end
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, params: params }

    let!(:word) { create(:word) }

    context 'valid params' do
      let(:params) do
        { id: word.id }
      end

      it 'delete word' do
        expect { subject }.to change(Word, :count).from(1).to(0)
      end
    end
  end

end
