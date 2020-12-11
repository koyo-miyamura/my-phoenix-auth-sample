create_schema:
	mysqldump -uroot --compact -d myapp_dev | sed -e '/\/\*/d' > master.sql

migrate:
	mix ecto.migrate
