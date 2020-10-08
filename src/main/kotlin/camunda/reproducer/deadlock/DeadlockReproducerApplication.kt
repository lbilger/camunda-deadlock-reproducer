package camunda.reproducer.deadlock

import org.camunda.bpm.engine.ProcessEngine
import org.camunda.bpm.spring.boot.starter.annotation.EnableProcessApplication
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.AbstractDependsOnBeanFactoryPostProcessor
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.autoconfigure.flyway.FlywayMigrationInitializer
import org.springframework.context.annotation.Import
import org.springframework.scheduling.annotation.EnableScheduling


@SpringBootApplication
@EnableScheduling
@EnableProcessApplication
@Import(CamundaDependsOnFlywayBeanFactoryPostProcessor::class)
class DeadlockReproducerApplication

fun main(args: Array<String>) {
    SpringApplication.run(DeadlockReproducerApplication::class.java, *args)
}

class CamundaDependsOnFlywayBeanFactoryPostProcessor:AbstractDependsOnBeanFactoryPostProcessor(ProcessEngine::class.java, FlywayMigrationInitializer::class.java)