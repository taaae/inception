COMPOSE_DIR=srcs

all:
	(cd $(COMPOSE_DIR) && docker compose up)

clean:
	(cd $(COMPOSE_DIR) && docker compose down)

fclean:
	(cd $(COMPOSE_DIR) && docker compose down -v)

gen_secrets:
	@mkdir -p secrets
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout ./secrets/nginx-ssl.key \
	-out ./secrets/nginx-ssl.crt \
	-subj "/CN=example.com" \
	> /dev/null 2>&1
	@openssl rand -base64 15 | tr -dc 'a-zA-Z0-9' | head -c 10 > ./secrets/mariadb-password.txt
	@openssl rand -base64 15 | tr -dc 'a-zA-Z0-9' | head -c 10 > ./secrets/mariadb-root.txt
	@openssl rand -base64 15 | tr -dc 'a-zA-Z0-9' | head -c 10 > ./secrets/wordpress-admin-password.txt
	@openssl rand -base64 15 | tr -dc 'a-zA-Z0-9' | head -c 10 > ./secrets/wordpress-user-password.txt


re: fclean all

.PHONY: all clean fclean re gen_secrets