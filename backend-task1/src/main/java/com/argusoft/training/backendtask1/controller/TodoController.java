package com.argusoft.training.backendtask1.controller;


import com.argusoft.training.backendtask1.model.Todo;
import com.argusoft.training.backendtask1.service.TodoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/todos")
@CrossOrigin
public class TodoController {


    private final TodoService todoService;

    @Autowired
    public TodoController(TodoService todoService){
        this.todoService = todoService;
    }

    @GetMapping("/{userId}")
    public ResponseEntity<List<Todo>> getTodosByUserId(@PathVariable Long userId) {
        List<Todo> todos = todoService.getTodosByUserId(userId);
        return ResponseEntity.ok(todos);
    }

    // Endpoint to add a new todo for a specific user
    @PostMapping("/{userId}")
    public ResponseEntity<Todo> addTodoForUser(@PathVariable Long userId, @RequestBody Todo todo) {
        Todo savedTodo = todoService.addTodoForUser(userId, todo);
        return new ResponseEntity<>(savedTodo, HttpStatus.CREATED);
    }

    @DeleteMapping("/{todoId}")
    public ResponseEntity<Todo> deleteTodoById(@PathVariable Long todoId) {
        Todo isDeleted = todoService.deleteTodoById(todoId);
        if (isDeleted != null) {
            return ResponseEntity.ok(isDeleted);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/{todoId}/toggle")
    public ResponseEntity<Todo> toggleTodoStatus(
            @PathVariable Long todoId
    ) {
        Todo updatedTodo = todoService.toggleTodoStatus(todoId);
        if (updatedTodo != null) {
            return ResponseEntity.ok(updatedTodo);
        }
        return ResponseEntity.notFound().build();
    }
}
