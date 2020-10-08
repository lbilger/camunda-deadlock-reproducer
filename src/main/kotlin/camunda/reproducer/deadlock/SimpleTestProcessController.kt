package camunda.reproducer.deadlock

import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.flywaydb.core.Flyway
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/public/process-rest/simple-process")
class SimpleTestProcessController(
    private val runtimeService: RuntimeService,
    private val taskService: TaskService
) {
    @RequestMapping(value = ["/start"], method = [RequestMethod.POST])
    fun startProcess() {
        runtimeService.startProcessInstanceByKey(SimpleTestProcess.PROCESS_DEFINITION_KEY)
    }

    @RequestMapping(value = ["/task/{taskId}/complete"], method = [RequestMethod.POST])
    fun completeTask(@PathVariable("taskId") taskId: String) {
        taskService.complete(taskId)
    }
}
