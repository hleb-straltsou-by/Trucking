package com.itechart.trucking.dao;

import com.itechart.trucking.domain.Client;

import java.util.List;
import java.util.Optional;

/**
 * @author Gleb Streltsov
 * @version 1.1
 * @since 2017-11-15
 */
public interface ClientDao {

    /**
     * gets client by id from storage
     * @param id - unique id of existed client
     * @return Optional client object
     */
    Optional<Client> getClientById(Integer id);

    /**
     * gets list of clients from storage
     * @param namePattern - part of client name for searching
     * @return list of found clients objects
     */
    List<Client> findClientsByName(String namePattern);

    /**
     * Returns all instances of the {@link Client} by the given page number and size.
     * @param pageNumber - offset of instances
     * @param pageSize - count of instances in page
     * @return list of clients objects per page
     */
    List<Client> getClientsByPage(int pageNumber, int pageSize);

    /**
     * gets count of clients in storage
     * @return count of client objects in storage
     */
    int getClientCount();

    /**
     * adds new cleint to the storage
     * @param client - new client object
     * @return added client object with unique id
     */
    Client addClient(Client client);

    /**
     * updates existed client in storage
     * @param client - new client with id, if client doesn't contain
     *                 id, client object will be saved in storage
     */
    void updateClient(Client client);

    /**
     * deletes existed client in storage
     * @param client - existed client with id in storage
     */
    void deleteClient(Client client);
}