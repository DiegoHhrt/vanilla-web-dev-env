# vanilla-web-dev-env

A very bare-bones vanilla web-app development environment intended as a replacement for Xampp because even for people refusing to use node and a framework, auto-refresh and containerization is useful.

## Setup

### Prerequisites

Grab the following files and drop them into the **root** of your project folder:

- `compose.yaml`
- `bs-config.js_sample` (rename to `bs-config.js` after downloading)
- `nginx.conf_sample` (rename to `nginx.conf` after downloading)
- `.env` (create from `sample._env`)

### Configuration

1.  **.env file**
    It is recommended to leave the environment variables values as default if no specific reason to change them, except for database credentials and database name.

    `MYSQL_CONTAINER_NAME`:
    You can change the container name that will identify the database service so it matches your existing setup if needed. It has to be the same as the `PMA_HOST` variable to maintain communication between containers.

2.  **Database configuration in your web application**

    Here's an example on how php db configuration relates to the db environment variables.

    `MYSQL_CONTAINER_NAME`: host_name

    `MYSQL_USER`: user_string

    `MYSQL_PASSWORD`: a-verY-s3curePW

    `MYSQL_DATABASE`: db_name


    ```php
        <?php
        define("DBUSER", "user_string"); //Same as MYSQL_USER
        define("DBHOST", "host_name"); //This has to be the same name as the database service name inside the docker compose file  
        define("PASSWORD", "a-verY-s3curePW"); //Same as MYSQL_PASSWORD
        define("DB", "db_name"); //Same as MYSQL_DATABASE

        function connect()
        {
            $con = mysqli_connect(DBHOST, DBUSER, PASSWORD, DB);

            if (!$con) {
                mysqli_connect_error();
                mysqli_connect_errno();
                echo "No se pudo acceder a la base de datos";
            }
            return $con;
        }
    ```

4.  **bs-config.js file**
    No changes needed unless you want to change the BrowserSync port or domain.

5.  **nginx configuration**
    The root field must match the container's side volume path defined in `compose.yaml` (`/var/www/html` by default).
    If you change the volume path in `compose.yaml`, make sure to update the nginx config accordingly.

No other changes are necessary unless you have specific requirements.

## Usage

1.  Build and start the containers from the root of your project folder:

    ```bash
    docker compose up -d
    ```

2.  Access your web application at `http://localhost:8080` (or the port you specified in the `.env` file).

3.  Access phpMyAdmin at `http://localhost:9021` (or the port you specified in the `.env` file) to manage your database.

4.  To stop the containers, run:

    ```bash

    docker compose down

    ```

## Notes

A demo web application is included in order to test the setup. This docker cluster should be oblivious to a project's internal structure as long as the WEB_VOL path is mapped to the project's root folder.

To test how to access different template routes navigate to: `http://localhost:8080/demo-project/templates/another-entrypoint/entry.html`

In case you're running into issues with the live refresh not working on windows either:

- Verify that docker desktop is configured to use the WSL2 or VirtioFS backend
- Add the following to your `bs-config.js` file:

  ```js
  watchOptions: {
      usePolling: true,
      interval: 1000,
  },
  ```

  This will force BrowserSync to use polling to detect file changes, which can be more reliable on certain Windows setups.

  Note that depending on the polling interval you set, your developer environment specs and the size of your project folder this might have (or not) a noticeable performance impact.
