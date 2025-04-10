all: build deploy

build:
	poetry lock
	eval $(minikube docker-env)
	docker build -t webapp .
deploy:
	kubectl apply -f webapp.yaml -n my-model