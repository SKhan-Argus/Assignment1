package com.argusoft.training.backendtask1.model;

import lombok.Data;

@Data
public class LoginResponse {
    private boolean success;
    private String message;
    private User user;
}
