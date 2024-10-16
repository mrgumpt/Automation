package calculatorBdd;

import org.junit.runner.RunWith;
import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
    features = "src/test/resources/features",
    glue = "calculatorBdd.steps",
    plugin = {"pretty", "html:target/cucumber-reports"},
    tags = "@soma"
)
public class TestRunner {

}