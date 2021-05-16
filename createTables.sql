CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  created_at timestamp with time zone default current_timestamp,
  updated_at timestamp with time zone default current_timestamp,
  username varchar(30) NOT NULL,
  bio varchar(400),
  img_url varchar(200),
  phone varchar(25),
  email varchar(40),
  password varchar(50),
  status varchar(15),
  CHECK(COALESCE(phone, email) IS NOT NULL),
  CHECK(password IS NOT NULL)
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  created_at timestamp with time zone default current_timestamp,
  udpated_at timestamp with time zone default current_timestamp,
  url varchar(200) NOT NULL,
  user_id integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  caption varchar(240),
  lat REAL CHECK(lat IS NULL OR (lat >= -90 AND lat <= 90)),
  lng REAL CHECK(lng IS NULL OR (lng >= -180 AND lng <= 180)),
  CHECK((lat IS NULL) = (lng IS NULL))
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  created_at timestamp with time zone default current_timestamp,
  udpated_at timestamp with time zone default current_timestamp,
  contents varchar(240) NOT NULL,
  user_id integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  post_id integer NOT NULL REFERENCES posts(id) ON DELETE CASCADE
);

CREATE TABLE likes (
  id SERIAL PRIMARY KEY,
  created_at timestamp with time zone default current_timestamp,
  user_id integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  comment_id integer REFERENCES comments(id) ON DELETE CASCADE,
  post_id integer REFERENCES posts(id) ON DELETE CASCADE,
  CHECK(
	  COALESCE((post_id)::BOOLEAN::INTEGER, 0)
	  +
	  COALESCE((comment_id)::BOOLEAN::INTEGER, 0)
	  = 1
  ),
	UNIQUE(user_id, post_id, comment_id)
);

CREATE TABLE photo_tags (
  id SERIAL PRIMARY KEY,
  created_at timestamp with time zone default current_timestamp,
  udpated_at timestamp with time zone default current_timestamp,
  post_id integer NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  user_id integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  x integer NOT NULL,
  y integer NOT NULL,
  UNIQUE(user_id, post_id)
);

CREATE TABLE caption_tags (
  id SERIAL PRIMARY KEY,
  created_at timestamp with time zone default current_timestamp,
  post_id integer NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  user_id integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE(user_id, post_id)
);

CREATE TABLE hashtags (
  id SERIAL PRIMARY KEY,
  created_at timestamp with time zone default current_timestamp,
  title varchar(20) NOT NULL UNIQUE
);

CREATE TABLE hashtags_posts (
  id SERIAL PRIMARY KEY,
  hashtag_id integer NOT NULL REFERENCES hashtags(id) ON DELETE CASCADE,
  post_id integer NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  UNIQUE(hashtag_id, post_id)
);

CREATE TABLE followers (
  id SERIAL PRIMARY KEY,
  created_at timestamp with time zone default current_timestamp,
  user_id integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  follower_id integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE(user_id, follower_id)
);