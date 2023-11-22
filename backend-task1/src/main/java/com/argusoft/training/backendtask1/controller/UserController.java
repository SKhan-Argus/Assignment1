package com.argusoft.training.backendtask1.controller;


import com.argusoft.training.backendtask1.model.LoginResponse;
import com.argusoft.training.backendtask1.model.SignupResponse;
import com.argusoft.training.backendtask1.model.User;
import com.argusoft.training.backendtask1.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService){
        this.userService=userService;
    }

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody User user){
        SignupResponse signupResponse = new SignupResponse();

        if(userService.findByUsername(user.getUsername()) != null){
            signupResponse.setMessage("Username already exists");
            signupResponse.setSuccess(false);
            return ResponseEntity.status(HttpStatus.CONFLICT).body(signupResponse);
        }

        userService.addUser(user);
        signupResponse.setMessage("User added successfully");
        signupResponse.setSuccess(true);
        return ResponseEntity.ok(signupResponse);
    }


    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody User testUser){
        User user = userService.findByUsername(testUser.getUsername());
        //System.out.println(user);
        if( user != null){

            if(testUser.getPassword().equalsIgnoreCase(user.getPassword())){
                LoginResponse loginResponse = new LoginResponse();
                loginResponse.setSuccess(true);
                loginResponse.setMessage("Login Successfully");
                //loginResponse.setToken(token);
                loginResponse.setUser(user);
                return ResponseEntity.ok(loginResponse);
            }
        }

        LoginResponse loginResponse = new LoginResponse();
        loginResponse.setSuccess(false);
        loginResponse.setMessage("Invalid Credentials");

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(loginResponse);
    }


    @GetMapping("/demo/{userId}")
    public User findByUserId(@PathVariable("userId") Long userId){
        return userService.findUserById(userId);
    }

}
