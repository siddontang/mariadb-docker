all: build

build:
	@docker build -t siddontang/mariadb .

clean:
	@docker rmi siddontang/mariadb
