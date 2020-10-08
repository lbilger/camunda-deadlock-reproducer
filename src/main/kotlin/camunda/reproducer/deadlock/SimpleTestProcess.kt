package camunda.reproducer.deadlock

import org.camunda.bpm.engine.delegate.JavaDelegate
import org.camunda.bpm.engine.variable.Variables
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.util.*

@Configuration
class SimpleTestProcess {
    companion object {
        const val PROCESS_DEFINITION_KEY = "simple_test_process"
    }

    @Suppress("UsePropertyAccessSyntax")
    @Bean
    fun loadDataDelegate(): JavaDelegate {
        return JavaDelegate { execution ->
            execution.setVariables(Variables.createVariables().apply {
                (1..100).forEach { n -> putValue("uuid$n", UUID.randomUUID().toString()) }
            })
        }
    }
}
