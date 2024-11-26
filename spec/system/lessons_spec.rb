require 'rails_helper'

RSpec.describe 'レッスン閲覧機能', type: :system do
  let(:user) { create(:user) }
  let!(:publish_lesson) { create(:lesson, name: 'Rspecの基礎講座', overview: 'Rspecの基礎が1時間で学べる', instructor: '雨宮匠', publish: true) } # rubocop:disable RSpec/LetSetup
  let!(:unpublished_lesson) { create(:lesson, name: '初めてのスノーボード', instructor: 'Alice Sherry', publish: false) }

  before do
    user.confirm
    sign_in user
  end

  it '公開中のレッスンのみレッスンの一覧画面から閲覧できること' do
    visit root_path
    expect(page).to have_content 'Rspecの基礎講座'
    expect(page).to have_content '雨宮匠'
    expect(page).not_to have_content '初めてのスノーボード'
    expect(page).not_to have_content 'Alice Sherry'
  end

  it '公開中のレッスンの詳細が閲覧できること' do
    visit root_path
    click_on 'Rspecの基礎講座'
    expect(page).to have_content 'Rspecの基礎講座'
    expect(page).to have_content 'Rspecの基礎が1時間で学べる'
    expect(page).to have_content '雨宮匠'
  end

  it '公開されてないレッスン詳細にはアクセスできない' do
    visit lesson_path(unpublished_lesson)
    expect(page).to have_content 'ActiveRecord::RecordNotFound'
  end
end
