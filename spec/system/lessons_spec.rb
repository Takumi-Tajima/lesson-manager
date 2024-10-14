require 'rails_helper'

RSpec.describe 'レッスン閲覧機能', type: :system do
  let(:user) { create(:user) }

  before do
    user.confirm
    sign_in user
    create(:lesson, name: 'Rspecの基礎講座', overview: 'Rspecの基礎が1時間で学べる', instructor: '雨宮匠', publish: true)
  end

  it 'レッスンの一覧が閲覧できること' do
    visit root_path
    expect(page).to have_content 'Rspecの基礎講座'
    expect(page).to have_content '雨宮匠'
  end

  it 'レッスンの詳細が閲覧できること' do
    visit root_path
    click_on 'Rspecの基礎講座'
    expect(page).to have_content 'Rspecの基礎講座'
    expect(page).to have_content 'Rspecの基礎が1時間で学べる'
    expect(page).to have_content '雨宮匠'
  end
end
