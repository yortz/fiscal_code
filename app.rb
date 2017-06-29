require 'bundler'
require 'roda'
require 'codice_fiscale'

module FiscalCode
  class App < Roda
    plugin :json
    route do |r|
      r.is "calculate" do
        r.get do
          fiscal_code = get_fiscal_code(r.params)
          {fiscal_code: fiscal_code}
        end
      end
    end

    private

    def get_fiscal_code(params)
      is_italian?(params) ? italian_fiscal_code(params) : foreign_fiscal_code(params)
    end

    def italian_fiscal_code(params)
      CodiceFiscale.calculate(
        name:           params['name'],
        surname:        params['surname'],
        gender:         get_gender(params['gender']),
        birthdate:      format_date(params['birthdate']),
        province_code:  params['province_code'],
        city_name:      params['city_name']
      )
    end

    def foreign_fiscal_code(params)
      CodiceFiscale.calculate(
        name:           params['name'],
        surname:        params['surname'],
        gender:         get_gender(params['gender']),
        birthdate:      format_date(params['birthdate']),
        country_name:   params['country_name']
      )
    end

    def is_italian?(params)
      params['province_code'].present? && params['city_name'].present?
    end

    def get_gender(sex)
      sex == 'male' ? :male : :female
    end

    def format_date(birthdate)
      date = birthdate.split('/').map(&:to_i)
      year = date[2]
      month = date[1]
      day = date[0]
      Date.new(year, month, day)
    end

  end
end
