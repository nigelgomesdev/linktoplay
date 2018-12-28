# README

* Scope: Music library with Playlist, Tracks and ability to link to third party websites.

* ERD:
					 USER(1)---(*)LIBRARY	  ARTIST
									(1)         (1)
									/\		     |
								   /  \			 |
								  /	   \		(*)
					 PLAYLIST---(*)     (*)---TRACK(*)--------(1)SOURCE
						 (1)				 (1) 
						   \			     /
							\				/
							 \			   /
							  (*)         (*)
							  PLAYLIST_TRACK  


* System dependencies
	- Postgres(9.5)
	- Ruby(2.5.3)
	- Rails(5.2.2)

* Configuration
	- Devise, Simple form, Kaminari

* Database Initialization
	- rails db:reset

* How to run the test suite
	- #TODO

* Services (job queues, cache servers, search engines, etc.)
	- None

* Deployment instructions
	- Heroku

