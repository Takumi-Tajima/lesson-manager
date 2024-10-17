require 'rails_helper'

RSpec.describe 'レッスン開催日登録機能', type: :system do
  let(:admin) { create(:admin) }
  let(:lesson) { create(:lesson, name: 'Rubyオンラインレッスン') }

  before do
    sign_in admin
  end

  context '2024-10-15にアクセスした時' do
    before do
      travel_to '2024-10-15'
      create(:lesson_date, lesson:, date: '2024-10-16', start_at: '12:00', end_at: '15:00',
                           capacity: 5, url: 'https://example.zoom.us')
    end

    it 'レッスン開催日の一覧と詳細を閲覧できる' do
      visit admins_lessons_path
      click_on 'Rubyオンラインレッスン'
      click_on '開催日一覧'
      expect(page).to have_content '開催日'
      expect(page).to have_content '開始時間'
      expect(page).to have_content '終了時間'
      expect(page).to have_content '定員'
      lesson_date_row = page.find('table tr', text: '2024-10-16')
      within(lesson_date_row) do
        expect(page).to have_link '2024-10-16'
        expect(page).to have_content '12:00'
        expect(page).to have_content '15:00'
        expect(page).to have_content '5'
        click_on '2024-10-16'
      end
      expect(page).to have_content 'Rubyオンラインレッスン'
      expect(page).to have_content '12:00'
      expect(page).to have_content '15:00'
      expect(page).to have_content '5'
      expect(page).to have_content 'https://example.zoom.us'
    end

    it 'レッスンの開催日を作成できること' do
      visit admins_lessons_path
      lesson_row = page.find('table tr', text: 'Rubyオンラインレッスン')
      within(lesson_row) do
        click_on '開催日一覧'
      end
      click_on 'レッスンの開催日を追加する'
      # 開催日程
      select '2024', from: 'lesson_date[date(1i)]'
      select '11', from: 'lesson_date[date(2i)]'
      select '10', from: 'lesson_date[date(3i)]'
      # 開始時間
      select '15', from: 'lesson_date[start_at(4i)]'
      select '00', from: 'lesson_date[start_at(5i)]'
      # 終了時間
      select '20', from: 'lesson_date[end_at(4i)]'
      select '00', from: 'lesson_date[end_at(5i)]'
      fill_in '定員',	with: '80'
      fill_in '開催場所URL',	with: 'https://example.taji.zoom'
      expect do
        click_on '登録'
        expect(page).to have_content '開催日を登録しました'
      end.to change(lesson.lesson_dates, :count).by(1)
      lesson_date_row = page.find('table tr', text: '2024-11-10')
      within(lesson_date_row) do
        expect(page).to have_content '15:00'
        expect(page).to have_content '20:00'
        expect(page).to have_content '80'
      end
    end

    it 'レッスンの開催日を編集できること' do
      visit admins_lessons_path
      lesson_row = page.find('table tr', text: 'Rubyオンラインレッスン')
      within(lesson_row) do
        click_on '開催日一覧'
      end
      click_on '2024-10-16'
      click_on '編集'
      # 開催日程
      select '2024', from: 'lesson_date[date(1i)]'
      select '12', from: 'lesson_date[date(2i)]'
      select '31', from: 'lesson_date[date(3i)]'
      # 開始時間
      select '18', from: 'lesson_date[start_at(4i)]'
      select '30', from: 'lesson_date[start_at(5i)]'
      # 終了時間
      select '21', from: 'lesson_date[end_at(4i)]'
      select '30', from: 'lesson_date[end_at(5i)]'
      fill_in '定員',	with: '19'
      fill_in '開催場所URL',	with: 'https://example.takumi.zoom'
      expect do
        click_on '登録'
        expect(page).to have_content '開催日を編集しました'
      end.not_to change(lesson.lesson_dates, :count)
      expect(page).not_to have_content '2024-10-16'
    end

    it 'レッスンの開催日を削除できること' do
      visit admins_lessons_path
      lesson_row = page.find('table tr', text: 'Rubyオンラインレッスン')
      within(lesson_row) do
        click_on '開催日一覧'
      end
      click_on '2024-10-16'
      expect do
        accept_confirm do
          click_on '削除'
        end
        expect(page).to have_content '開催日を削除しました'
      end.to change(lesson.lesson_dates, :count).by(-1)
      expect(page).not_to have_content '2024-10-16'
    end

    it '不正な値の場合、開催日を登録できないこと' do
      visit admins_lessons_path
      lesson_row = page.find('table tr', text: 'Rubyオンラインレッスン')
      within(lesson_row) do
        click_on '開催日一覧'
      end
      click_on 'レッスンの開催日を追加する'
      # 開催日程
      select '2024', from: 'lesson_date[date(1i)]'
      select '9', from: 'lesson_date[date(2i)]'
      select '15', from: 'lesson_date[date(3i)]'
      # 開始時間
      select '08', from: 'lesson_date[start_at(4i)]'
      select '00', from: 'lesson_date[start_at(5i)]'
      # 終了時間
      select '06', from: 'lesson_date[end_at(4i)]'
      select '30', from: 'lesson_date[end_at(5i)]'
      fill_in '定員',	with: '101'
      fill_in '開催場所URL',	with: ''
      expect do
        click_on '登録'
        expect(page).to have_content 'エラーがあります。確認してください'
      end.not_to change(lesson.lesson_dates, :count)
      expect(page).to have_content '本日以降の日程を選択してください。'
      expect(page).to have_content '終了時刻は、開始時刻よりも後に設定してください'
      expect(page).to have_content '定員は1人から100人の間で設定してください'
      expect(page).to have_content '必須項目です'
    end
  end
end
