package com.io.example.repository.query;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor(access = AccessLevel.PRIVATE)
public class TestEntityQuery {

    public static final String SELECT_CLAUSE = """
            entity.id,
            entity.fieldA,
            entity.fieldB,
            entity.fieldC,
            entity.fieldD,
            entity.fieldE
            """;

    public static final String FROM_CLAUSE = """
            test_entity entity
            """;

    public static final String WHERE_CLAUSE = """
            """;

    public static final String ORDER_ID = "id";

}
