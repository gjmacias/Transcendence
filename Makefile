# Variables globales
COMPOSE_FILE=srcs/docker-compose.yml
COMPOSE_CMD=docker-compose -f $(COMPOSE_FILE)

# Colores para logs bonitos
BLUE=\033[1;34m
GREEN=\033[1;32m
NC=\033[0m

# Target por defecto
all: set_host
	@echo "$(GREEN)==> Iniciando todos los servicios...$(NC)"
	@cd srcs && docker-compose up -d --build

# Targets por servicio individual
waf:
	@echo "$(BLUE)==> Levantando WAF...$(NC)"
	@$(COMPOSE_CMD) up --build waf

frontend:
	@echo "$(BLUE)==> Levantando FRONTEND (depende de WAF)...$(NC)"
	@$(COMPOSE_CMD) up --build frontend

backend:
	@echo "$(BLUE)==> Levantando BACKEND...$(NC)"
	@$(COMPOSE_CMD) up --build backend-sqlite

node:
	@echo "$(BLUE)==> Levantando NODE SERVER (depende del frontend)...$(NC)"
	@$(COMPOSE_CMD) up --build node

blockchain:
	@echo "$(BLUE)==> Levantando BLOCKCHAIN (depende del backend)...$(NC)"
	@$(COMPOSE_CMD) up --build blockchain

# Setear entrada en /etc/hosts
set_host:
	@if ! grep -q "transcendence.es" /etc/hosts; then \
		echo "$(BLUE)==> Añadiendo transcendence.es a /etc/hosts...$(NC)"; \
		echo "127.0.0.1	transcendence.es" | sudo tee -a /etc/hosts > /dev/null;\
	fi

# Bajar todos los servicios
down:
	@echo "$(BLUE)==> Bajando servicios...$(NC)"
	@$(COMPOSE_CMD) down

# Limpiar entrada del /etc/hosts
remove_host:
	@if grep -q "127.0.0.1	transcendence.es" /etc/hosts; then \
		echo "$(BLUE)==> Quitando transcendence.es de /etc/hosts...$(NC)"; \
		sudo sed -i '/127.0.0.1[[:space:]]\+transcendence.es/d' /etc/hosts; \
	fi

# Limpiar contenedores e imágenes
clean: down remove_host
	@echo "$(BLUE)==> Limpiando imágenes y volúmenes...$(NC)"
	@docker rmi srcs-backend-sqlite srcs-blockchain srcs-frontend srcs-node srcs-waf || true
	@docker volume rm srcs_backend-sqlite-data srcs_blockchain-data srcs_frontend-data srcs_node-data || true

# Full clean
fclean: clean

# Full clean and prune
prune:  clean
	@echo "$(BLUE)==> Clean and Prune, say yes...$(NC)"
	@docker system prune

# Rebuild completo
re: clean all

#Logs para debuggeo

logs:
	@echo "$(BLUE)==> Mostrando logs en tiempo real... (Ctrl+C para salir)$(NC)"
	@$(COMPOSE_CMD) logs -f

logs-waf:
	@echo "$(BLUE)==> Logs WAF (Ctrl+C para salir)$(NC)"
	@$(COMPOSE_CMD) logs -f waf

logs-frontend:
	@echo "$(BLUE)==> Logs FRONTEND (Ctrl+C para salir)$(NC)"
	@$(COMPOSE_CMD) logs -f frontend

logs-backend:
	@echo "$(BLUE)==> Logs BACKEND-SQLITE (Ctrl+C para salir)$(NC)"
	@$(COMPOSE_CMD) logs -f backend-sqlite

logs-node:
	@echo "$(BLUE)==> Logs NODE SERVER (Ctrl+C para salir)$(NC)"
	@$(COMPOSE_CMD) logs -f node

logs-block:
	@echo "$(BLUE)==> Logs BLOCKCHAIN (Ctrl+C para salir)$(NC)"
	@$(COMPOSE_CMD) logs -f blockchain

#Status para ver que hay encendido y como esta
status:
	@echo "$(GREEN)==> Estado actual de los servicios Docker:$(NC)"
	@docker ps --filter name=backend-sqlite \
	           --filter name=blockchain \
	           --filter name=frontend \
	           --filter name=node \
	           --filter name=waf


.PHONY: all waf frontend backend node blockchain set_host down remove_host clean fclean re logs logs-waf logs-frontend logs-backend logs-node logs-blockchain

