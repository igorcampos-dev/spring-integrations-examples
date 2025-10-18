package com.io.example.dbReader.init;

import com.io.example.dbReader.model.entity.TestEntity;
import com.io.example.dbReader.repository.TestEntityRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Random;
import java.util.stream.IntStream;

@Slf4j
@Component
@RequiredArgsConstructor
public class Init implements CommandLineRunner {

    private final TestEntityRepository repository;
    private final Random random = new Random();

    @Override
    public void run(String... args){
        log.info("Generating 10k random entities...");
        log.info("Saving entities in parallel...");
        this.getRandomEntities()
            .parallelStream()
            .forEach(repository::save);
        log.info("Done!");
    }

    private List<TestEntity> getRandomEntities(){
        return IntStream.range(0, 10_000)
                .mapToObj(i -> TestEntity.builder()
                        .fieldA("A" + random.nextInt(10000))
                        .fieldB("B" + random.nextInt(10000))
                        .fieldC(random.nextInt(1000))
                        .fieldD(random.nextDouble() * 1000)
                        .fieldE(random.nextBoolean())
                        .build())
                .toList();
    }

}
