
taskモデル

|  カラム名  |  データ型  |
| ---- | ---- |
|  name  |  string  |
|  content  |  text  |


## デプロイ手順

1.アセットプリコンパイルをする

`$ rails assets:precompile RAILS_ENV=production`

2.コミットする

`$ git add -A`

`$ git commit -m "init"`

3.Herokuに新しいアプリケーションを作成

`$ heroku create`

4.Heroku buildpackを追加

`$ heroku buildpacks:set heroku/ruby`

5.Herokuへデプロイ

`$ git push heroku master`

6.データベースの移行

`$ heroku run rails db:migrate`


## 使用しているgem

- gem 'rails', '= 5.2.3'
- gem 'pg', '>= 0.18', '< 2.0'
- gem 'puma', '~> 3.11'
- gem 'sass-rails', '~> 5.0'
- gem 'uglifier', '>= 1.3.0'
- gem 'coffee-rails', '~> 4.2'
- gem 'turbolinks', '~> 5'
- gem 'jbuilder', '~> 2.5'
- gem 'bootsnap', '>= 1.1.0'
