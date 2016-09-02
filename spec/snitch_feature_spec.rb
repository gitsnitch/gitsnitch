require 'rails_helper'

feature 'Snitch' do

  context 'when on front page' do
    scenario 'should display a GitHub login link' do
      visit '/'
      expect(page).to have_content 'GitSnitch'
      expect(page).to have_button 'Authorize Search'
    end
  end

end
