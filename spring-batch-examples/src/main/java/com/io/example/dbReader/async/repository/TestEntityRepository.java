package com.io.example.dbReader.async.repository;

import com.io.example.dbReader.async.model.entity.TestEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TestEntityRepository extends JpaRepository<TestEntity, Long> {
}
