all: set_host
	@docker compose -f ./srcs/docker-compose.yml up -d --build

set_host:
	@if ! grep -q "transcendence.es" /etc/hosts; then \
		sudo echo "127.0.0.1	transcendence.es" | sudo tee -a /etc/hosts > /dev/null;\
	fi

down:
	@docker compose -f ./srcs/docker-compose.yml down


remove_host:
	@if grep -q "127.0.0.1	transcendence.es" /etc/hosts; then \
		sudo sed -i '/127.0.0.1	transcendence.es/d' /etc/hosts; \
	fi

clean: down remove_host 
	@docker rmi srcs-backend-SQLite srcs-blockchain srcs-frontend srcs-Node_js srcs-WAF
	@docker volume rm srcs_backend-SQLite-data srcs_blockchain-data srcs_frontend-data srcs_Node_js-data srcs_WAF-data


fclean: clean

re: clean all


.PHONY: all set_host down clean remove_host fclean re