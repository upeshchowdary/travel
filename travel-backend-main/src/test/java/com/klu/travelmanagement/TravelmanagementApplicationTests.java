package com.klu.travelmanagement;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import com.klu.travelmanagement.TravelmanagementApplication;

@SpringBootTest(
    classes = TravelmanagementApplication.class,
    properties = {
        "spring.datasource.url=jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE",
        "spring.datasource.driverClassName=org.h2.Driver",
        "spring.datasource.username=sa",
        "spring.datasource.password=",
        "spring.jpa.hibernate.ddl-auto=create-drop",
        "spring.jpa.show-sql=false"
    }
)
class TravelmanagementApplicationTests {

	@Test
	void contextLoads() {
	}

}
