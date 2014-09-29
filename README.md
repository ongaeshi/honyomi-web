# Honyomi Web

It is a bundler template of Honyomi web application for apache passenger.

Honyomi is a ebook (pdf) search engine written by Ruby. It have command line interface and web application. It will accelerate the ebook of your life.

## !!NOTICE!!

**Please protect by authentication** if you put the files that is copyrighted to the Internet.

This code is using basic authentication.

## Quick Start

It's a quick start guide to install honyomi under the `/var/www/html/`.  
And directory design is below.  

|Path|Contens|
|:---|:---|
|data/|HONYOMI_DATABASE_DIR|
|vendor/|Gem install dir|
|book/|Book files (.pdf, etc)|
|public/|DocumentRoot|

### Step1. Install Honyomi

```
$ cd /var/www/html
$ git clone https://github.com/ongaeshi/honyomi-web.git honyomi
$ cd /var/www/html/honyomi
$ bundle install --path vendor/bundle
```

### Step2. Initialize Honyomi Database

```
$ cd /var/www/html/honyomi
$ HONYOMI_DATABASE_DIR=/var/www/html/honyomi/data bundle exec honyomi init
```

### Step3. Adding contents to Honyomi Database

1. Copy pdf to book/ folder
2. honyomi add

```
$ cd /var/www/html/honyomi
$ HONYOMI_DATABASE_DIR=/var/www/html/honyomi/data bundle exec honyomi add book/aaa.pdf
A 1 aaa (16 pages)
```

### Step4. Apache Configuration

Put your configuration to `virtualhosts.conf` like this.

```
$ cat /etc/httpd/conf.d/virtualhost.conf
<VirtualHost *:80>
   ServerName honyomi.example.com
   DocumentRoot /var/www/html/honyomi/public
   PassengerHighPerformance on
   SetEnv HONYOMI_DATABASE_DIR /var/www/html/honyomi/data
</VirtualHost>

# for Basic Authentication
<Directory /var/www/html/honyomi>
    AllowOverride All
</Directory>
```

Edit /var/www/html/honyomi/.htaccess

```diff
AuthType     Basic
AuthName     "Honyomi"
-AuthUserFile /path/to/.htpasswd
+AuthUserFile /var/www/html/honyomi.htpasswd
require      valid-user
```

Create .htpasswd

```
$ cd /var/www/html/honyomi
$ htpasswd -c .htpasswd username
Adding password for username.
New password: xxxx
Re-type new password: xxxx
```

Restart apache.

```
$ sudo /etc/init.d/httpd restart
```

### Step5. Check it on you browser

Open url like `http://honyomi.example.com/` which you specified.  
It works fine if you saw milk bottle icon.

![honyomi-web](https://github.com/ongaeshi/honyomi/blob/master/images/honyomi-01.png)

Thant's all. finished.

## License

Copyright (c) 2014 ongaeshi

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

