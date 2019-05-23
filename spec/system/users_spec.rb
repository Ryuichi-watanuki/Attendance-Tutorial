require 'rails_helper'

describe 'ユーザー機能', type: :system do
  let(:admin) { create(:admin) }
  
  before do
    visit login_path
    fill_in 'メールアドレス', with: admin.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end
  
  it 'ユーザー情報画面が表示される' do
    expect(page).to have_content 'システム管理者'
  end
end
