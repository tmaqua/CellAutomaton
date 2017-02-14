# Env.
 - Ruby  2.2.0
 - Rails 4.2.3
 - SQLite3
 - Slim
 - Rspec
 - FactoryGirl

# SetUp

## 開発環境
- ルートディレクトリで以下のコマンドを実行をすることで
`http://localhost:3000`
でアクセス出来ます
- Ruby2.2.0以降がpc上で実行可能である必要があります

~~~
bundle install --path=vendor/bundle --jobs=4
bundle exec rake db:migrate
bundle exec rails s
~~~

## 本番環境(gitとsshの知識必須)
- 2017/02/14現在、研究室内のpc(ipアドレス: 131.206.19.97)上で動作しています

- 開発環境でプログラムに何か変更を加えた場合、本番環境に適用させるには
~~~
git add .
git commit
git push origin master
bundle exec cap production deploy
~~~
コマンドを実行することで同じ状態になります

- 上記のコマンドを実行するためにはsshの設定が必要ですが、
個人的な事情(学外->学内LAN->研究室と2段階でログインしていた)があるので同じようにはいかないと思います

- 研究室内から上記コマンドを実行するために、`config/deploy/production.rb`の10行目~16行目`ssh_commandsから最終行まで`をコメントアウトし、5行目の`keys: %w(~/.ssh/ishizaka-lab/id_rsa)`を開発者の環境に合わせます

- id:ishizaka、password:Ish*****-labで研究室内のpc(ipアドレス: 131.206.19.97)にログインできるので自分でsshの設定を行って下さい

- ざっくりとsshの手順(調べて)
~~~
自分のpc
ssh-keygenコマンドでid_rsaとid_rsa.pubが作成される
id_rsa.pubの中身をコピー

研究室内pc(上記のアカウントでログイン)
~/.ssh/authorized_keysにid_rsa.pubの中身を貼り付け
~~~

- また`config/deploy.rb`の7行目`set :repo_url, 'https://github.com/tmaqua/CellAutomaton.git'`は村上のgithubアカウントが設定されていますが、今後の事を考え新しいgitリポジトリを設定したほうが無難です
