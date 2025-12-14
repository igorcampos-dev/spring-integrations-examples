CREATE TABLE caffeine_description (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

INSERT INTO caffeine_description (description)
VALUES ('Caffeine is a high-performance, in-memory caching library for Java.');
