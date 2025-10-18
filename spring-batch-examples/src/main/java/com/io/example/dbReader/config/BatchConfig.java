package com.io.example.dbReader.config;

import com.io.example.dbReader.model.dto.TestDto;
import com.io.example.dbReader.model.entity.TestEntity;
import com.io.example.dbReader.listener.LoggingStepListener;
import com.io.example.dbReader.mapper.TestEntityToDtoMapper;
import com.io.example.dbReader.service.TestService;
import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.launch.support.TaskExecutorJobLauncher;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.integration.async.AsyncItemProcessor;
import org.springframework.batch.integration.async.AsyncItemWriter;
import org.springframework.batch.item.ItemWriter;
import org.springframework.batch.item.database.JdbcPagingItemReader;
import org.springframework.batch.item.database.Order;
import org.springframework.batch.item.database.builder.JdbcPagingItemReaderBuilder;
import org.springframework.batch.item.database.support.H2PagingQueryProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.core.task.SimpleAsyncTaskExecutor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Future;

import static com.io.example.dbReader.repository.query.TestEntityQuery.*;

@Configuration
@RequiredArgsConstructor
public class BatchConfig {

    private final TestService testService;

    @Bean
    public JobLauncher asyncJobLauncher(JobRepository jobRepository) throws Exception {
        TaskExecutorJobLauncher jobLauncher = new TaskExecutorJobLauncher();
        jobLauncher.setJobRepository(jobRepository);
        jobLauncher.setTaskExecutor(new SimpleAsyncTaskExecutor());
        jobLauncher.afterPropertiesSet();
        return jobLauncher;
    }

    @Bean
    public AsyncItemProcessor<TestEntity, TestDto> asyncProcessor(AsyncTaskExecutor asyncTaskExecutor) {
        AsyncItemProcessor<TestEntity, TestDto> processor = new AsyncItemProcessor<>();
        processor.setDelegate(new TestEntityToDtoMapper());
        processor.setTaskExecutor(asyncTaskExecutor);
        return processor;
    }

    @Bean
    public AsyncItemWriter<TestDto> asyncWriter(ItemWriter<TestDto> itemWriter) {
        AsyncItemWriter<TestDto> writer = new AsyncItemWriter<>();
        writer.setDelegate(itemWriter);
        return writer;
    }

    @Bean
    public ItemWriter<TestDto> writerDelegate() {
        return items -> items.forEach(testService::print);
    }

    @Bean
    public AsyncTaskExecutor asyncTaskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(10);
        executor.setMaxPoolSize(50);
        executor.setQueueCapacity(500);
        executor.setThreadNamePrefix("batch-async-");
        executor.initialize();
        return executor;
    }

    @Bean
    public Step asyncStep(JobRepository jobRepository,
                     PlatformTransactionManager transactionManager,
                     JdbcPagingItemReader<TestEntity> asyncReader,
                     AsyncItemProcessor<TestEntity, TestDto> asyncProcessor,
                     AsyncItemWriter<TestDto> asyncWriter,
                     @Value("${spring.batch.chunk-size}") int chunkSize) {

        return new StepBuilder("asyncStep", jobRepository)
                .<TestEntity, Future<TestDto>>chunk(chunkSize, transactionManager)
                .reader(asyncReader)
                .processor(asyncProcessor)
                .writer(asyncWriter)
                .listener(new LoggingStepListener())
                .build();
    }

    @Bean
    public JdbcPagingItemReader<TestEntity> asyncReader(
            DataSource dataSource,
            @Value("${spring.batch.batch-size}") int batchSize
    ) {
        return new JdbcPagingItemReaderBuilder<TestEntity>()
                .name("asyncReader")
                .dataSource(dataSource)
                .queryProvider(createQueryProvider())
                .pageSize(batchSize)
                .rowMapper(new BeanPropertyRowMapper<>(TestEntity.class))
                .build();
    }

    private H2PagingQueryProvider createQueryProvider() {
        H2PagingQueryProvider queryProvider = new H2PagingQueryProvider();
        queryProvider.setSelectClause(SELECT_CLAUSE);
        queryProvider.setFromClause(FROM_CLAUSE);
        Map<String, Order> sortKeys = new HashMap<>();
        sortKeys.put(ORDER_ID, Order.ASCENDING);
        queryProvider.setSortKeys(sortKeys);
        return queryProvider;
    }

}
