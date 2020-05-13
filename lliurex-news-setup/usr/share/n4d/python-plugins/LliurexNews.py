import os
import bcrypt
import tempfile
import ConfigParser
import shutil
import time
import lliurex.net

from jinja2 import Environment
from jinja2.loaders import FileSystemLoader
from jinja2 import Template


class LliurexNews:
	
	BASE_DIR="/usr/share/lliurex-news-setup/llx-data/"
	CONTENT_BASE_DIR=BASE_DIR+"content/"
	#HTACCESS=CONTENT_BASE_DIR+".htaccess"
	#ADMIN_DATA=CONTENT_BASE_DIR+"data/"
	CONFIG_DATA=BASE_DIR+"config/config.production.json"
	CONFIG_CLI_FILE=BASE_DIR+"config/.ghost-cli"
	CONFIG_SYSTEMD_FILE=BASE_DIR+"systemd/ghost_news.service"
	TEMPLATE_DIR=BASE_DIR+""
	SQL_TEMPLATE="news.sql"
	CONFIG_THEMES_DIR=BASE_DIR+"themes/lliurex-theme"
	APACHE_CONF_FILE=BASE_DIR+"apache2/news-server.conf"
	APACHE_EXTERNAL_CONF=BASE_DIR+"apache2/news.conf"
	EASY_SITE=BASE_DIR+"/easy-site/news-admin.json"
	EASY_SITE_ICON=BASE_DIR+"/easy-site/news-admin.png"
	
	NEWS_BASE_DIR="/var/www/news/"
	NEWS_CONTENT_DIR=NEWS_BASE_DIR+"content/"
	NEWS_CONFIG_FILE=NEWS_BASE_DIR+"config.production.json"
	NEWS_SYSTEMD_FILES=NEWS_BASE_DIR+"/system/files/"

	APACHE_FILE_SITES_CONFIGURATION="/etc/apache2/sites-enabled/000-default.conf"
	APACHE_EXTERNAL_DIR="/etc/apache2/lliurex-location"
	EASY_SITES_DIR="/var/www/srv/links/"
	EASY_SITES_DIR_ICON="/var/www/srv/icons/"
	
	
	def __init__(self):
	
		self.dbg=1
		self.template=None
		self.template_vars=["DB_USER","DB_PWD","DB_NAME","ADMIN_USER","ADMIN_PWD","ADMIN_EMAIL","DEFAULT_LOCALE"]
		
	#def init

	def _debug(self,message):

		try:
			if self.dbg==1:
				print("[LliurexNewsServer]:%s"%(str(message)))
							
		except Exception as e:
			print ("[LliurexNewsServer] (_debug) %s" %(str(e)))
			
#def__debug
	
	def parse_template(self,template_path):
		
		print("* Parsing template...")

		config = ConfigParser.ConfigParser()
		config.optionxform=str
		config.read(template_path)
		
		self.template={}
		try:

			self.template["DB_USER"]=config.get("news","DB_USER")
			self.template["DB_PWD"]=config.get("news","DB_PWD")
			self.template["DB_NAME"]=config.get("news","DB_NAME")
			self.template["ADMIN_USER"]=config.get("news","ADMIN_USER")
			self.template["ADMIN_PWD"]=config.get("news","ADMIN_PWD")
			self.template["ADMIN_EMAIL"]=config.get("news","ADMIN_EMAIL")
			self.template["DEFAULT_LOCALE"]=config.get("news","DEFAULT_LOCALE")
		
			self.load_template(self.template)
			return [True,""]
			
		except Exception as e:
			msg="Parsing template.Error: %s"%(str(e))
			self._debug(msg)
			return [False,""]
		
		
		
		
	#def parse_template
	
	
	def load_template(self,template):
		
		print("* Loading template...")
		
		try:
			if not type({})==type(template):
				return [False,""]
				
			for var in self.template_vars:
				if var not in template:
					return [False,""]
				
			self.template=template

			try:

				self.template["EXTERNAL_IP"]=lliurex.net.get_ip(objects["VariablesManager"].get_variable("EXTERNAL_INTERFACE"))
				
			except:
				import xmlrpclib as x
				
				c=x.ServerProxy("https://server:9779")
				self.template["EXTERNAL_IP"]=lliurex.net.get_ip(c.get_variable("","VariablesManager","EXTERNAL_INTERFACE"))

			self.template["ADMIN_PWD"]=self.create_password_bhash(self.template["ADMIN_PWD"])

		except Exception as e:
			msg="Loading Template.Error: %s"%str(e)
			self._debug(msg)
			return [False,""]

		return [True,""]
		
	#def load_template
	
	
	def mysql_service_init(self):
		
		print("* Initializing mysql root passwd (if needed) ...")
		
		try:
			os.system("sudo mysql_root_passwd -i")
		except Exception as e:
			msg="Initializing mysql service.Error %s"%(str(e))
			self._debug(msg)
			return[False,""]

		return [True,""]
		
	#def mysql_service_init


	def create_db(self):
		
		print("* Creating database...")
		
		
		if self.template==None:
			msg="Creating database.Error: template not exists"
			self._debug(msg)
			return [False,""]
		
		try:	
			cmd='mysql -u%s -p%s -e "drop database IF EXISTS %s"'%(self.template["DB_USER"],self.template["DB_PWD"],self.template["DB_NAME"])
			os.system(cmd)
			
			cmd='mysql -u%s -p%s -e "create database %s"'%(self.template["DB_USER"],self.template["DB_PWD"],self.template["DB_NAME"])
			os.system(cmd)
			
			file_path=self.process_sql_template()
			if file_path==None:
				msg="Creating database.Error processing sql template"
				self._debug(msg)
				return [False,""]
			cmd="mysql -u %s -p%s %s < %s"%(self.template["DB_USER"],self.template["DB_PWD"],self.template["DB_NAME"],file_path)
			os.system(cmd)
			os.remove(file_path)

		except Exception as e:
			msg="Creating database.Error: %s"%(str(e))
			self._debug(msg)
			return[False,""]	
		
		return [True,""]
		
	#def init_sql
	
	def create_db_user(self):
	
		print("* Creating mysql user ...")
		
		try:
			db_pass=self.template["DB_PWD"]
			db_user=self.template["DB_USER"]
			db_name=self.template["DB_NAME"]
			cmd='mysql -uroot -p$(mysql_root_passwd -g) -e "GRANT ALL PRIVILEGES ON %s.* TO \'%s\'@localhost IDENTIFIED BY \'%s\'"'%(db_name, db_user,db_pass)
			ret=os.system(cmd)

		except Exception as e:
			msg="Creating mysql user.Error: %s"%(str(e))
			self._debug(msg)
			return [False,""]	
		
		return [True,ret]
		
	#def generate_user	
	
	
	def create_password_bhash(self,password):
		
		print("* Generating admin password...")
		
		salt=bcrypt.gensalt(10)
		return bcrypt.hashpw(password,bcrypt.gensalt(10))
		
	#def create_password_bhash
	
	
	def process_sql_template(self):
		
		print("* Procesing SQL template...")
		try:
			template_dir=LliurexNews.TEMPLATE_DIR
			sql_template_file=LliurexNews.SQL_TEMPLATE
			tpl_env = Environment(loader=FileSystemLoader(template_dir))
			sql_template = tpl_env.get_template(sql_template_file)
			content = sql_template.render(self.template).encode('UTF-8')

			tmp_file=tempfile.mktemp()
			f=open(tmp_file,"w")
			f.write(content)
			f.close()
			
			return tmp_file
		except Exception as e:
			msg="Processing SQL template.Error: %s"%(str(e))
			self._debug(msg)
			return None
		
		
	#def process_sql_template

				
	
	def clean_old_files(self):
		
		print("* Cleaning old News data...")
		
		
		try:
			if os.path.exists(LliurexNews.NEWS_CONFIG_FILE):
				os.system("rm -f %s"%LliurexNews.NEWS_CONFIG_FILE)

			
			for dir in [LliurexNews.NEWS_CONTENT_DIR]:
				if os.path.exists(dir):
					os.system("rm -rf %s"%dir)

		except Exception as e:
			msg="Cleaning old News data.Error: %s"%(str(e))
			self._debug(msg)
			return[False,""]			
				
		return [True,""]
		
	#def clean_old_files
	
	def copy_new_files(self):
		
		print("* Copying new News files...")

		try:

			if not os.path.exists(LliurexNews.NEWS_BASE_DIR):
				cmd="mkdir %s"%(LliurexNews.NEWS_BASE_DIR)
				os.system(cmd)

				
			cmd="cp %s %s"%(LliurexNews.CONFIG_DATA,LliurexNews.NEWS_CONFIG_FILE)
			os.system(cmd)

			cmd="cp %s %s"%(LliurexNews.CONFIG_CLI_FILE,LliurexNews.NEWS_BASE_DIR)
			os.system(cmd)
			
			cmd="cp -r %s %s"%(LliurexNews.CONTENT_BASE_DIR,LliurexNews.NEWS_BASE_DIR)
			os.system(cmd)
			
			if not os.path.exists(LliurexNews.NEWS_CONTENT_DIR+"data"):
				cmd="mkdir %s"%(LliurexNews.NEWS_CONTENT_DIR+"data")
				os.system(cmd)
			
			if not os.path.exists(LliurexNews.NEWS_CONTENT_DIR+"apps"):
				cmd="mkdir %s"%(LliurexNews.NEWS_CONTENT_DIR+"apps")
				os.system(cmd)

			if not os.path.exists(LliurexNews.NEWS_CONTENT_DIR+"logs"):
				cmd="mkdir %s"%(LliurexNews.NEWS_CONTENT_DIR+"logs")	
				os.system(cmd)

			if not os.path.exists(LliurexNews.NEWS_CONTENT_DIR+"themes"):
				cmd="mkdir %s"%(LliurexNews.NEWS_CONTENT_DIR+"themes")	
				os.system(cmd)

			if not os.path.exists(LliurexNews.NEWS_CONTENT_DIR+"themes/lliurex-theme"):
				cmd="ln -sf %s %s"%(LliurexNews.CONFIG_THEMES_DIR,LliurexNews.NEWS_CONTENT_DIR+"themes/lliurex-theme")
				os.system(cmd)
			
		except Exception as e:
			msg="Copying new News files.Error: %s"%(str(e))
			self._debug(msg)
			return[False,""]
			
		return [True,""]
		
	#def copy_new_files
	
	def process_config_file(self):
		
		print("* Procesing config template...")
		
		try:
			template_dir=LliurexNews.NEWS_BASE_DIR
			template_file="config.production.json"
			
			tpl_env = Environment(loader=FileSystemLoader(template_dir))
			template = tpl_env.get_template(template_file)
			content = template.render(self.template).encode('UTF-8')
			
			f=open(template_dir+template_file,"w")
			f.write(content)
			f.close()		

			for dir in [LliurexNews.NEWS_CONTENT_DIR]:
				if os.path.exists(dir):
					os.system("chown -R www-data:www-data %s"%dir)
						
			cmd="find /var/www/news/* -type d -exec chmod 775 {} \;"
			os.system(cmd)

			cmd="find /var/www/news/* -type f -exec chmod 664 {} \;"
			os.system(cmd)

		except Exception as e:
			msg="Processing config template.Error: %s"%(str(e))
			self._debug(msg)
			return[False,""]	

		return [True,""]
		
	#def process_config_file


	def enable_apache(self):

		print("* Enabling apache site")

		try:
			cmd="cp %s /tmp"%(LliurexNews.APACHE_FILE_SITES_CONFIGURATION)
			os.system(cmd)

			cmd="cp %s %s"%(LliurexNews.APACHE_CONF_FILE, "/etc/apache2/sites-available/")
			os.system(cmd)
			if not os.path.exists(LliurexNews.APACHE_EXTERNAL_DIR):
				cmd="mkdir %s"%(LliurexNews.APACHE_EXTERNAL_DIR)
				os.system(cmd)

			if os.path.exists(LliurexNews.APACHE_EXTERNAL_DIR):	
				cmd="cp %s %s"%(LliurexNews.APACHE_EXTERNAL_CONF,LliurexNews.APACHE_EXTERNAL_DIR)
				os.system(cmd)

			try:
				modify=True
				path, dirs, files = next(os.walk(LliurexNews.APACHE_EXTERNAL_DIR))
				number_files=len(files)
				print("* Editing apache2 000-default.conf file")
				if ( number_files > 0 ):
					if os.path.isfile(LliurexNews.APACHE_FILE_SITES_CONFIGURATION):
						with open(LliurexNews.APACHE_FILE_SITES_CONFIGURATION, "r") as in_file:
							buf = in_file.readlines()
						with open(LliurexNews.APACHE_FILE_SITES_CONFIGURATION, "w") as out_file:
							for line in buf:
								if  "lliurex-location" in line:
									modify=False
								else:
									if ( "<Directory /var/www/admin-center>" in line ) & (modify):
										line = "include /etc/apache2/lliurex-location/*.conf\n" + line
								out_file.write(line)
				else:
					if os.path.isfile(LliurexNews.APACHE_FILE_SITES_CONFIGURATION):
						with open(LliurexNews.APACHE_FILE_SITES_CONFIGURATION, "r") as in_file:
							buf = in_file.readlines()
						with open(LliurexNews.APACHE_FILE_SITES_CONFIGURATION, "w") as out_file:
							for line in buf:
								if "lliurex-location" in line:
									line = "\n"
								out_file.write(line)
			except Exception as e:
				msg="Editing apache2 000-default.conf file.Error: %s"%(str(e))
				self._debug(msg)
				cmd="cp /tmp/000-default.conf %s"%(LliurexNews.APACHE_FILE_SITES_CONFIGURATION)
				os.system(cmd)
				return [False,""]					
				
					
		except Exception as e:
			msg="Enabling apache site.Error: %s"%(str(e))
			self._debug(msg)
			return[False,""]
			
		return [True,""]	


	#def enable_apache

	def enable_systemd(self):

		print("* Disabling previous systemd service")

		try:
			cmd="systemctl stop ghost_news.service"
			os.system(cmd)

			time.sleep(1)
			cmd="systemctl disable ghost_news.service"
			os.system(cmd)

		except Exception as e:
			pass	
			
		
		print("* Enabling systemd service...")
		
		try:
		
			cmd="cp %s %s"%(LliurexNews.CONFIG_SYSTEMD_FILE,LliurexNews.NEWS_SYSTEMD_FILES)
			os.system(cmd)

			cmd="ln -sf /var/www/news/system/files/ghost_news.service /lib/systemd/system/ghost_news.service"
			os.system(cmd)

			cmd="systemctl enable ghost_news.service"
			os.system(cmd)

			time.sleep(1)
			cmd="systemctl start ghost_news.service"
			os.system(cmd)
			
		except Exception as e:
			msg="Enabling systemd service.Error: %s"%(str(e))
			self._debug(msg)	
			return [False,""]

		
		return [True,""]
		
	#def enable_easy_site

	def enable_easy_site(self):
		
		print("* Enabling easy site...")
		
		try:
			if os.path.exists(LliurexNews.EASY_SITES_DIR):
				shutil.copy(LliurexNews.EASY_SITE,LliurexNews.EASY_SITES_DIR)
				
			if os.path.exists(LliurexNews.EASY_SITES_DIR_ICON):
				shutil.copy(LliurexNews.EASY_SITE_ICON,LliurexNews.EASY_SITES_DIR_ICON)	
		except Exception as e:
			msg="Enabling easy-site.Error: %s"%(str(e))
			self._debug(msg)
			return [False,""]

		return [True,""]
		
	#def enable_easy_site

	
	def enable_cname(self):

		'''
		template_dir=LliurexNews.CONTENT_BASE_DIR
		tpl_env = Environment(loader=FileSystemLoader(template_dir))
		template = tpl_env.get_template(LliurexNews.CNAME)
		
		content = template.render(self.template).encode('UTF-8')
		f=open("/var/lib/dnsmasq/config/cname-owncloud","w")
		f.write(content)
		f.close()
		
		'''
		print("* Enabling News cname...")

		f=open("/etc/n4d/key","r")
		magic_key=f.readline().strip("\n")
		f.close()
		import xmlrpclib as x
		c=x.ServerProxy("https://server:9779")
		result = c.set_internal_dns_entry(magic_key,"Dnsmasq","news-server")
		if result['status'] == True:
			os.system("systemctl restart dnsmasq.service")
			return [True,""]
		else:
			msg="Enabling News cname.Error: %s"%(str(result['msg']))
			self._debug(msg)
			return [False,""]
		
		
	#def enable_cname
	
	def enable_apache_conf(self):
		
		#os.system("a2enmod ldap")
		os.system("a2enmod proxy")
		os.system("a2enmod proxy_http") 
		os.system("a2enmod ssl")
		os.system("a2enmod rewrite")
		os.system("a2enmod headers")
		os.system("a2ensite default-ssl.conf")
		os.system("a2ensite news-server.conf")
		os.system("systemctl restart apache2.service")
		
	#def enable_apache_mods
	
	
	def initialize_news(self,template):
		
		try:

			status,ret=self.load_template(template)
			if not status:
				return [False,"1"]

			status,ret=self.mysql_service_init()
			if not status:
				return [False,"2"]

			status,ret=self.create_db_user()
			if not status:
				return [False,"3"]

			status,ret=self.create_db()
			if not status:
				return [False,"4"]

			status,ret=self.clean_old_files()
			if not status:
				return [False,"6"]

			status,ret=self.copy_new_files()
			if not status:
				return [False,"7"]

			status,ret=self.process_config_file()
			if not status:
				return [False,"8"]

			status,ret=self.enable_apache()
			if not status:
				return [False,"9"]	

			status,ret=self.enable_systemd()
			if not status:
				return [False,"10"]

			status,ret=self.enable_easy_site()
			if not status:
				return [False,"11"]	
			
			status,ret=self.enable_cname()
			if not status:
				return [False,"12"]
				
			self.enable_apache_conf()
				
			return [True,"SUCCESS"]
			
		except Exception as e:
			msg="Error in News setup process: %s"%(str(e))
			self._debug(msg)
			return [False," ?"]
		
	#def initlializ_owncloud
	
	
#class LliurexNews

if __name__=="__main__":
	
	lo=LliurexNews()
	lo.parse_template("/home/netadmin/news.ini")
	lo.mysql_service_init()
	lo.create_db_user()
	lo.create_db()
	lo.clean_old_files()
	lo.copy_new_files()
	lo.process_config_file()
	lo.enable_apache()
	lo.enable_systemd()
	lo.enable_easy_site()
	lo.enable_cname()
	lo.enable_apache_conf()


	
	