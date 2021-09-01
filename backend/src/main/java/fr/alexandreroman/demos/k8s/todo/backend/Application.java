/*
 * Copyright (c) 2021 VMware, Inc. or its affiliates
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// make package-backend
// then patch Image 
// then get Image number in Harbor
// then change values.yml

package fr.alexandreroman.demos.k8s.todo.backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@SpringBootApplication
public class Application {

    final static String RELISE = "Application v0.27.1 - 25.aout.2021 - 14:19";

    private static final Logger LOGGER = LoggerFactory.getLogger(Application.class);

    // private final static String DEMO_GREETING = "DEMO_GREETING";
    private final static String MY_POD_NAME         = "MY_POD_NAME";
    private final static String MY_NODE_NAME        = "MY_NODE_NAME";
    private static final String MY_POD_NAMESPACE    = "MY_POD_NAMESPACE";
    private static final String MY_POD_IP           = "MY_POD_IP";
    private static final String MY_POD_SERVICE_ACCOUNT = "MY_POD_SERVICE_ACCOUNT";
    
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);

        LOGGER.info("Starting:" + RELISE);
        // LOGGER.info("Starting:DEMO_GREETING:" + System.getenv(DEMO_GREETING));
        LOGGER.info("Starting:MY_NODE_NAME:" + System.getenv(MY_NODE_NAME) + ":");
        LOGGER.info("Starting:MY_POD_NAMESPACE:" + System.getenv(MY_POD_NAMESPACE)+ ":");
        LOGGER.info("Starting:MY_POD_NAME:" + System.getenv(MY_POD_NAME)+ ":");
        LOGGER.info("Starting:MY_POD_IP:" + System.getenv(MY_POD_IP)+ ":");
        LOGGER.info("Starting:MY_POD_SERVICE_ACCOUNT:" + System.getenv(MY_POD_SERVICE_ACCOUNT)+ ":");
        LOGGER.info("Starting:availableProcessors:" + Runtime.getRuntime().availableProcessors() + ":");

    }
}

@Configuration
class WebConfiguration implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**").allowedMethods("*");
    }
}
