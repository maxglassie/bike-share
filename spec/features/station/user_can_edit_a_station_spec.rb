require_relative '../../spec_helper'

RSpec.describe "when user visits edit station path" do
  it "user can edit a station" do
    City.create(name: "Auckland")
    boulder = City.create(name: "Boulder")
    station = boulder.stations.create(name: "Max Station", dock_count: 4, installation_date: "2005-07-09")


    visit("/stations/#{station.id}/edit")

    fill_in 'station[name]', with: "Amara Station"
    fill_in 'station[dock_count]', with: 6
    select  "Auckland", from: 'station[city_id]'

    fill_in 'station[installation_date]', with: "2016-04-08"

    click_on 'Submit Changes'

    station = Station.last
    expect(station.dock_count).to eq(6)
    expect(page).to have_content("Auckland")
    expect(current_path).to eq("/stations/#{station.id}")
  end
end
