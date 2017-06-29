#Fiscal Code

A ruby web app based on the [Roda](https://github.com/jeremyevans/roda/tree/master/spec) framework which has calculates the Italian fiscal code.

##Usage

Clone the app

```
 $ cd fiscal_code
 $ gem install bundler
 $ bundle
```

Assuming you are running your app via [pow](http://pow.cx/) you can access the only endpoint available, this is a simple get request that accepts several params and responds with some json containing the calculated italian fiscal code from the params you have been providing.
The app makes use of the [codice_fiscale](https://github.com/topac/codice_fiscale) gem to makes those calculations.

##Example:

###Foreign citizen born in Italy
```
$ curl --request GET http://fiscal_code.dev/calculate?name=Mario&surname=Rossi&gender=male&birthdate=01/01/1978&country_name=Francia
```

### Italian citizen born in Italy

```
$ curl --request GET http://fiscal_code.dev/calculate\?name\=Mario\&surname\=Rossi\&gender\=male\&birthdate\=01/06/1975\&province_code\=LC\&city_name\=Abbadia%20Lariana
```

##Test:

```
$ cd fiscal_code
$ bundle exec rspec
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
