all: mysql redis rabbitmq

mysql:
	sudo apt-get install mysql-server mysql-client -y
	# sudo service mysql status
	sudo service mysql start
	
	sudo mysql -u root -e "\
	ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456'; \
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION; \
	FLUSH PRIVILEGES; \
	"

	sudo mysql -u root -p123456 -t < sql/seckill.sql

redis:
	sudo apt update
	sudo apt install redis-server -y
	sudo service redis-server start

rabbitmq:
	sudo apt-get update
	sudo apt-get install rabbitmq-server -y
	sudo service rabbitmq-server start

	# 要创建的RabbitMQ用户名和密码
	RABBITMQ_USER="admin"
	RABBITMQ_PASSWORD="admin"
	# 创建新用户
	sudo rabbitmqctl add_user admin admin
	# 为新用户设置权限
	sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
	sudo rabbitmqctl set_user_tags admin administrator

	# rabbitmq 前端界面
	sudo rabbitmq-plugins enable rabbitmq_management

	# 列出rabbitmq用户
	sudo rabbitmqctl list_users

delete_rabbitmq_user:
	sudo rabbitmqctl delete_user admin

