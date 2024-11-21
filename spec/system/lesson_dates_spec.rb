require 'rails_helper'

RSpec.describe 'レッスン開催日閲覧', type: :system do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson, name: 'オンライン英会話', publish: true) }

  before do
    user.confirm
    sign_in user
    travel_to '2024-10-15'
    create(:lesson_date, lesson:, date: '2024-10-16', start_at: '10:00', end_at: '15:00',
                         capacity: 80)
  end

  it 'レッスンの開催日一覧を閲覧できること' do
    visit root_path
    click_on 'オンライン英会話'
    click_on '開催日一覧'
    expect(page).to have_content '開催日'
    expect(page).to have_content '2024-10-16'
    expect(page).to have_content '開始時間'
    expect(page).to have_content '10:00'
    expect(page).to have_content '終了時間'
    expect(page).to have_content '15:00'
    expect(page).to have_content '定員'
    expect(page).to have_content '80'
  end
end
