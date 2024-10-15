# require 'rails_helper'

# RSpec.describe 'レッスン開催日登録機能', type: :system do
#   let(:admin) { create(:admin) }
#   let(:lesson) { create(:lesson, name: 'Rubyオンラインレッスン') }
#   let!(:lesson_date) do
#     create(:lesson_date, lesson_id: lesson.id, date: '2024-10-15', start_at: '2024-10-15 12:00:00', end_at: '2024-10-15 15:00:00', capacity: 5,
#                          url: 'https://example.zoom.us')
#   end

#   before do
#     sign_in admin
#   end

#   it 'レッスン開催日の一覧を閲覧できる' do
#     travel_to '2024-10-13' do
#       visit admins_lessons_path
#       click_on 'Rubyオンラインレッスン'
#       click_on '開催日一覧'
#       expect(page).to have_content '開催日'
#       expect(page).to have_link '2024-10-15', href: admins_lesson_lesson_dates_path(lesson)
#       expect(page).to have_content '開始時間'
#       expect(page).to have_content '12:00'
#       expect(page).to have_content '終了時間'
#       expect(page).to have_content '15:00'
#       expect(page).to have_content '定員'
#       expect(page).to have_content '5'
#     end
#   end

#   it 'レッスン開催日の詳細を閲覧できる' do
#   end

#   it 'レッスンの開催日を作成できること' do
#   end

#   it 'レッスンの開催日を編集できること' do
#   end

#   it '不正な値の場合、開催日を登録できないこと' do
#   end

#   it 'レッスンの開催日を削除できること' do
#   end
# end
