# -*- coding: utf-8 -*-
require 'groonga'
Groonga::Database.open(File.join(ENV['HONYOMI_DATABASE_DIR'], 'db/honyomi.db'))
require 'honyomi/web/app'
