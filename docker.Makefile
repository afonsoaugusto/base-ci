docker-login:
	echo ${IMAGE_REGISTRY_TOKEN} | docker login -u ${IMAGE_REGISTRY_USERNAME} --password-stdin ${IMAGE_REGISTRY}

docker-build: docker-login
	docker build -t $(IMAGE_NAME_COMMIT) . && \
	docker push $(IMAGE_NAME_COMMIT) && \
	docker logout

docker-publish-branch: docker-login
	docker pull $(IMAGE_NAME_COMMIT)  && \
	docker tag $(IMAGE_NAME_COMMIT) $(IMAGE_NAME_BRANCH)  && \
	docker push $(IMAGE_NAME_BRANCH)

docker-publish: docker-login
	docker pull $(IMAGE_NAME_COMMIT)  && \
	docker tag $(IMAGE_NAME_COMMIT) $(IMAGE_NAME_LATEST)  && \
	docker push $(IMAGE_NAME_LATEST) && \
	docker logout

docker-scan:
	trivy --exit-code 1 $(IMAGE_NAME_COMMIT)

docker-clear:
	docker logout

docker-branch: docker-build docker-publish-branch docker-clear