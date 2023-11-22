package com.argusoft.training.backendtask1.service;

import com.argusoft.training.backendtask1.model.User;
import com.argusoft.training.backendtask1.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository){
        this.userRepository = userRepository;
    }


    public User addUser(User user){
        return userRepository.save(user);
    }

    public User findUserById(Long userId){
        return userRepository.findById(userId).orElse(null);
    }

    public User findByUsername(String username){
        return userRepository.findByUsername(username).orElse(null);
    }

    public User updateUser(User user){
        return userRepository.save(user);
    }
}
