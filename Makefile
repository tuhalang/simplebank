postgres:
	docker run --name postgres12 -e POSTGRES_USER=BANK -e POSTGRES_PASSWORD=123456a@ -p 5432:5432 -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=BANK --owner=BANK simple_bank

dropdb:
	docker exec -it postgres12 dropdb --username=BANK simple_bank

migrateup:
	migrate --path db/migration --database "postgresql://BANK:123456a@@localhost:5432/simple_bank?sslmode=disable" --verbose up

migratedown:
	migrate --path db/migration --database "postgresql://BANK:123456a@@localhost:5432/simple_bank?sslmode=disable" --verbose down

sqlc:
	sqlc generate
	
.PHONY: postgres createdb dropdb migrateup migratedown sqlc