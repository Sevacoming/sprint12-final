# Sprint 12 – CI/CD & Docker

Проект содержит:
- CI pipeline для Go (gofmt, vet, test)
- Dockerfile для сборки приложения
- GitHub Actions workflow для публикации Docker-образа по тегу

Docker image публикуется при push тега `v*`.
