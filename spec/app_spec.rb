require 'spec_helper'

describe FiscalCode::App, roda: :app do
  describe '#GET /calculate' do


    context "is NON italian citizen" do
      before { get('/calculate', {name: "Mario", surname: "Rossi", gender: "male", birthdate: "01/01/1978", country_name: "Francia"}) }

      it { expect(last_response).to be_successful }
      it "calculates fiscal code for foreign citizen" do
        fiscal_code = JSON.parse(last_response.body)["fiscal_code"]
        expect(fiscal_code).not_to be_empty
        expect(fiscal_code).to eq("RSSMRA78A01Z110H")
      end
    end

    context "is Italian citizen" do
      before { get('/calculate', {name: "Mario", surname: "Rossi", gender: "male", birthdate: "01/01/1987", province_code: 'LC', city_name: "Abbadia Lariana"}) }

      it { expect(last_response).to be_successful }
      it "calculates fiscal code for Italian citizen" do
        fiscal_code = JSON.parse(last_response.body)["fiscal_code"]
        expect(fiscal_code).not_to be_empty
        expect(fiscal_code).to eq("RSSMRA87A01A005V")
      end
    end
  end
end
