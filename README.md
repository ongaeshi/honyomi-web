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

When you faild to install Honyomi, Please refer.

- [Honyomi#Installation](https://github.com/ongaeshi/honyomi#installation)

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
