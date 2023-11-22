package com.argusoft.training.backendtask1.repository;

import com.argusoft.training.backendtask1.model.Todo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TodoRepository extends JpaRepository<Todo, Long> {
    List<Todo> findByUserId(Long userId);

    @Query("SELECT t FROM Todo t WHERE t.id = :todoId AND t.user.id = :userId")
    Optional<Todo> findByIdAndUserId(@Param("todoId") Long todoId, @Param("userId") Long userId);
}
