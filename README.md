# vanilla-web-dev-env

A very bare-bones vanilla web-app development environment intended as a replacement for Xampp because Xampp is lame

## Setup

### Prerequisites

Grab the following files and drop them into the root of your project folder:

- `compose.yaml`
- `Dockerfile`
- `bs-config.js_sample` (rename to `bs-config.js` after downloading)
- `.env` (create from `sample._env`)

### Configuration

1.  **.env file**
    It is recommended to leave the environment variables values as default if no specific reason to change them, except for database credentials and database name.

         - `MYSQL_CONTAINER_NAME`: You can change the container name that will identify the database service so it matches your existing setup if needed.

2.  **bs-config.js file**
    No changes needed unless you want to change the BrowserSync port or domain.

3.  **nginx configuration**
    The root field must match the container's side volume path defined in `compose.yaml` (`/var/www/html` by default).
    If you change the volume path in `compose.yaml`, make sure to update the nginx config accordingly.

No other changes are necessary unless you have specific requirements.

## Usage

1.  Build and start the containers from the root of your project folder:

    ```bash
    docker compose up -d --build
    ```

2.  Access your web application at `http://localhost:8080` (or the port you specified in the `.env` file).

3.  Access phpMyAdmin at `http://localhost:9021` (or the port you specified in the `.env` file) to manage your database.

4.  To stop the containers, run:

    ```bash

    docker compose down

    ```
