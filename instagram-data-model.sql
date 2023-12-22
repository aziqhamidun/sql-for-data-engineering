CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	name varchar(50) NOT NULL,
	email varchar(50) UNIQUE NOT NULL,
	phone_number varchar(50) UNIQUE
);

CREATE TABLE posts (
	post_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	caption TEXT,
	image_url VARCHAR(200),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
	comment_id SERIAL PRIMARY KEY,
	post_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	comment_text TEXT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (post_id) REFERENCES posts(post_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE likes (
	like_id SERIAL PRIMARY KEY,
	post_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (post_id) REFERENCES posts(post_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE followers (
	follower_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	follower_user_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (follower_user_id) REFERENCES users(user_id)
);
