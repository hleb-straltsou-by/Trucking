package com.itechart.trucking.dao;


import com.itechart.trucking.domain.User;

import java.util.List;
import java.util.Optional;

public interface UserDao {

    /**
     * gets user by id from storage
     *
     * @param id - unique id of existed client
     * @return Optional user object
     */
    Optional<User> getUserById(Integer id);


    /**
     * Returns all instances of the {@link User} by the given page number and size.
     *
     * @param offset        - offset of instances
     * @param recordPerPage - count of instances in page
     * @return list of users objects per page
     */
    List<User> getUsersByPage(int offset, int recordPerPage);


    /**
     * adds new user to the storage
     *
     * @param user - new client object
     * @return added user object with unique id
     */
    User addUser(User user);

    /**
     * updates existed user in storage
     *
     * @param user - new user with id, if user doesn't contain
     *             id, user object will be saved in storage
     */
    void updateUser(User user);

    /**
     * deletes existed user in storage
     *
     * @param user - existed client with id in storage
     */
    void deleteClient(User user);
}
