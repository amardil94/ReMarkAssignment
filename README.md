# ReMark Assignment by Amardil Deo

## Software Versions
- Ruby 3.3.1
- Rails 7.1.3.4

## Project Setup
Clone project, then run the following command:
```
bundle install
```

## Running the project
```
rails s
```

## Running csv import job
```
rails "csv:import[<path_to_files>]"
```

Replace <path_to_files> with the directory that contains movies.csv and reviews.csv

## Routes

- /movies - Movie overview
- /api/v1/movies - Get movie data via API in JSON format



