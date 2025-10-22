package com.io.example.dao;

import com.io.example.dto.JdbcClientCrudExampleDto;
import com.io.example.exception.JdbcClientCrudExampleException;
import org.instancio.Instancio;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.jdbc.core.simple.JdbcClient;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class JdbcClientCrudExampleDaoTest {

    private static final JdbcClientCrudExampleDto DTO = Instancio.create(JdbcClientCrudExampleDto.class);
    private static final Long ID = Instancio.create(Long.class);
    private static final List<JdbcClientCrudExampleDto> DTO_LIST = Instancio.ofList(JdbcClientCrudExampleDto.class).size(3).create();

    @Mock
    private JdbcClient jdbc;

    @Mock
    private JdbcClient.StatementSpec statementSpec;

    @Mock
    private JdbcClient.MappedQuerySpec<JdbcClientCrudExampleDto> selectSpec;

    @InjectMocks
    private JdbcClientCrudExampleDao dao;

    @Test
    @DisplayName("should insert record successfully")
    void shouldInsertRecordSuccessfully() {
        when(jdbc.sql(anyString())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getId())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getName())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getValue())).thenReturn(statementSpec);
        when(statementSpec.update()).thenReturn(1);

        dao.create(DTO);

        verify(statementSpec).update();
    }

    @Test
    @DisplayName("should retrieve all records successfully")
    void shouldRetrieveAllRecordsSuccessfully() {
        when(jdbc.sql(anyString())).thenReturn(statementSpec);
        when(statementSpec.query(JdbcClientCrudExampleDto.class)).thenReturn(selectSpec);
        when(selectSpec.list()).thenReturn(DTO_LIST);

        List<JdbcClientCrudExampleDto> result = dao.findAll();

        assertThat(result).hasSize(3).isEqualTo(DTO_LIST);
    }

    @Test
    @DisplayName("should retrieve record by id successfully")
    void shouldRetrieveRecordByIdSuccessfully() {
        when(jdbc.sql(anyString())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getId())).thenReturn(statementSpec);
        when(statementSpec.query(JdbcClientCrudExampleDto.class)).thenReturn(selectSpec);
        when(selectSpec.optional()).thenReturn(Optional.of(DTO));

        JdbcClientCrudExampleDto result = dao.findById(DTO.getId());

        assertThat(result).isEqualTo(DTO);
    }

    @Test
    @DisplayName("should throw exception when record not found by id")
    void shouldThrowExceptionWhenRecordNotFoundById() {
        when(jdbc.sql(anyString())).thenReturn(statementSpec);
        when(statementSpec.param(ID)).thenReturn(statementSpec);
        when(statementSpec.query(JdbcClientCrudExampleDto.class)).thenReturn(selectSpec);
        when(selectSpec.optional()).thenReturn(Optional.empty());

        assertThatThrownBy(() -> dao.findById(ID))
                .isInstanceOf(JdbcClientCrudExampleException.class)
                .hasMessageContaining("Failed to retrieve record for id = " + ID);
    }

    @Test
    @DisplayName("should update record successfully")
    void shouldUpdateRecordSuccessfully() {
        when(jdbc.sql(anyString())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getName())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getValue())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getId())).thenReturn(statementSpec);
        when(statementSpec.update()).thenReturn(1);

        dao.update(DTO.getId(), DTO.getName(), DTO.getValue());

        verify(statementSpec).update();
    }

    @Test
    @DisplayName("should throw exception when updating non-existent record")
    void shouldThrowExceptionWhenUpdatingNonExistentRecord() {
        when(jdbc.sql(anyString())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getName())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getValue())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getId())).thenReturn(statementSpec);
        when(statementSpec.update()).thenReturn(0);

        assertThatThrownBy(() -> dao.update(DTO.getId(), DTO.getName(), DTO.getValue()))
                .isInstanceOf(JdbcClientCrudExampleException.class)
                .hasMessageContaining("Failed to update record with id = " + DTO.getId());
    }

    @Test
    @DisplayName("should delete record successfully")
    void shouldDeleteRecordSuccessfully() {
        when(jdbc.sql(anyString())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getId())).thenReturn(statementSpec);
        when(statementSpec.update()).thenReturn(1);

        dao.delete(DTO.getId());

        verify(statementSpec).update();
    }

    @Test
    @DisplayName("should throw exception when deleting non-existent record")
    void shouldThrowExceptionWhenDeletingNonExistentRecord() {
        when(jdbc.sql(anyString())).thenReturn(statementSpec);
        when(statementSpec.param(DTO.getId())).thenReturn(statementSpec);
        when(statementSpec.update()).thenReturn(0);

        assertThatThrownBy(() -> dao.delete(DTO.getId()))
                .isInstanceOf(JdbcClientCrudExampleException.class)
                .hasMessageContaining("Failed to delete record with id = " + DTO.getId());
    }

}