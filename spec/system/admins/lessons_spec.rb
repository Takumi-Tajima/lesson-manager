require 'rails_helper'

RSpec.describe 'レッスン登録機能', type: :system do
  let(:admin) { create(:admin) }
  let!(:lesson) { create(:lesson, name: 'Rubyオンラインレッスン', overview: 'Rubyの基礎が1時間で身につきます。基本的な構文を習います。', instructor: '田島匠') }

  before do
    sign_in admin
  end

  it 'レッスンを一覧を確認できること' do
    visit admins_lessons_path
    expect(page).to have_content 'イベント名'
    expect(page).to have_link 'Rubyオンラインレッスン', href: admins_lesson_path(lesson)
    expect(page).to have_content '講師名'
    expect(page).to have_content '田島匠'
    expect(page).to have_content '公開状況'
    expect(page).to have_content '非公開'
  end

  it 'レッスン詳細を確認できること' do
    visit admins_lessons_path
    item_row = page.find('table tr', text: 'Rubyオンラインレッスン')
    within(item_row) do
      click_on 'Rubyオンラインレッスン'
    end
    expect(page).to have_content 'Rubyオンラインレッスン'
    expect(page).to have_content 'Rubyの基礎が1時間で身につきます。基本的な構文を習います。'
    expect(page).to have_content '田島匠'
    expect(page).to have_content '非公開'
  end

  it 'レッスンを新規登録できること' do
    visit admins_lessons_path
    click_on 'レッスンを登録'
    fill_in 'レッスン名',	with: '初心者のRailsコース'
    fill_in '概要',	with: '初心者が1からRailsの基礎を学ぶことができます。'
    fill_in '講師名',	with: '鈴木りょう'
    expect do
      click_on '登録'
      expect(page).to have_content 'レッスンを登録しました'
    end.to change(Lesson, :count).by(1)
    expect(page).to have_content '初心者のRailsコース'
    expect(page).to have_content '鈴木りょう'
    expect(page).to have_content '非公開'
    item_row = page.find('table tr', text: '初心者のRailsコース')
    within(item_row) do
      click_on '初心者のRailsコース'
    end
    expect(page).to have_content '初心者が1からRailsの基礎を学ぶことができます。'
  end

  it '不正な値の時は、新規登録できないこと' do
    visit admins_lessons_path
    click_on 'レッスンを登録'
    fill_in 'レッスン名',	with: ''
    fill_in '概要',	with: 'a' * 101
    fill_in '講師名',	with: 'a' * 51
    expect do
      click_on '登録'
      expect(page).to have_content 'エラーがあります。確認してください。'
    end.not_to change(Lesson, :count)
    expect(page).to have_current_path new_admins_lesson_path
    expect(page).to have_content 'レッスン名 必須項目です'
  end

  it 'レッスンを編集できること' do
    visit admins_lessons_path
    item_row = page.find('table tr', text: 'Rubyオンラインレッスン')
    within(item_row) do
      click_on 'Rubyオンラインレッスン'
    end
    click_on '編集'
    fill_in 'レッスン名',	with: 'PHPの基礎講座'
    fill_in '概要',	with: 'PHPでECサイトを作成してみよう'
    fill_in '講師名',	with: '佐藤匠'
    expect do
      click_on '登録'
      expect(page).to have_content 'レッスンを編集しました'
    end.not_to change(Lesson, :count)
    expect(page).to have_content 'PHPの基礎講座'
    expect(page).to have_content '佐藤匠'
    expect(page).to have_content 'PHPでECサイトを作成してみよう'
    expect(page).to have_content '非公開'
  end

  it '不正な値の時は、編集できないこと' do
    visit admins_lessons_path
    item_row = page.find('table tr', text: 'Rubyオンラインレッスン')
    within(item_row) do
      click_on 'Rubyオンラインレッスン'
    end
    click_on '編集'
    fill_in 'レッスン名',	with: ''
    fill_in '概要',	with: 'b' * 101
    fill_in '講師名',	with: 'b' * 51
    click_on '登録'
    expect(page).to have_current_path edit_admins_lesson_path(lesson)
    expect(page).to have_content 'レッスン名 必須項目です'
  end

  it 'レッスンを削除できること' do
    visit admins_lessons_path
    item_row = page.find('table tr', text: 'Rubyオンラインレッスン')
    within(item_row) do
      click_on 'Rubyオンラインレッスン'
    end
    expect do
      accept_confirm do
        click_on '削除'
      end
      expect(page).to have_content 'レッスンを削除しました'
    end.to change(Lesson, :count).by(-1)
    expect(page).not_to have_content 'Rubyオンラインレッスン'
    expect(page).not_to have_content '田島匠'
  end
end
