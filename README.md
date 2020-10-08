# Deadlock reproducer

This is a really minimal process application that can be used to reproduce the deadlock issue.

It is only meant for local startup.

***The code does _not_ show any best practices etc., it is meant to be small, quick and dirty, not clean and maintainable!***

## Running the engine

- Start the required containers using docker-compose:
  ```bash
  docker-compose up -d
  ```

- Build with maven:
  ```bash
  mvn clean install
  ```

- Run the application
  ```bash
  java -jar target/camunda-deadlock-reproducer-1.0-SNAPSHOT.jar
  ```


## Using the engine

Now you can:
- start 1000 new processes:
  ```bash
  for i in {1..1000}; do echo -n "$i "; curl -X POST localhost:8082/public/process-rest/simple-process/start; done
  ```
- complete all tasks:
  ```bash
  curl localhost:8082/rest/task | jq -r '.[].id' | while read taskId; do curl -X POST "localhost:8082/public/process-rest/simple-process/task/$taskId/complete"; done
  ```
- start a batch to delete all historic process instances:
  ```bash
  curl -X POST localhost:8082/rest/history/process-instance/delete -H 'Content-Type: application/json' -d '{"historicProcessInstanceQuery": {}}'
  ```

You should now see some deadlock exceptions in the log. If not, repeat the above, maybe with even more process instances.
