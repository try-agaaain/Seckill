all: mysql redis rabbitmq

mysql:
	sudo apt-get install mysql-server mysql-client
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
	sudo apt install redis-server
	sudo service redis-server start

rabbitmq:
	sudo apt-get update
	sudo apt-get install rabbitmq-server
	sudo service rabbitmq-server start

	# 要创建的RabbitMQ用户名和密码
	RABBITMQ_USER="admin"
	RABBITMQ_PASSWORD="admin"
	# 创建新用户
	sudo rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD
	# 为新用户设置权限
	sudo rabbitmqctl set_permissions -p / $RABBITMQ_USER ".*" ".*" ".*"
	sudo rabbitmqctl set_user_tags $RABBITMQ_USER administrator

	python3 rabbitmqadmin declare queue name=seckill.queue  auto_delete=false durable=false  --username=admin  --password=admin 