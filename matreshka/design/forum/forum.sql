------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Database Schema Definition                        --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------

BEGIN TRANSACTION;

CREATE DOMAIN user_identifier AS INTEGER NOT NULL;
CREATE TABLE users
 (user_identifier user_identifier NOT NULL PRIMARY KEY,
  email           CHARACTER VARYING NOT NULL UNIQUE,
  enabled         BOOLEAN NOT NULL);
INSERT INTO users (user_identifier, email, enabled) VALUES (0, '', true);

CREATE SEQUENCE user_identifier_sequence;
ALTER TABLE users ALTER COLUMN user_identifier
  SET DEFAULT nextval('user_identifier_sequence');
ALTER SEQUENCE user_identifier_sequence OWNED BY users.user_identifier;

CREATE TABLE passwords
 (user_identifier user_identifier NOT NULL PRIMARY KEY REFERENCES users,
  password        CHARACTER VARYING NOT NULL);

CREATE DOMAIN session_identifier AS CHARACTER (24) NOT NULL;
CREATE TABLE sessions
 (session_identifier session_identifier NOT NULL PRIMARY KEY,
  user_identifier    user_identifier NOT NULL REFERENCES users,
  creation_time      TIMESTAMP NOT NULL,
  last_accessed_time TIMESTAMP NOT NULL);


CREATE DOMAIN category_identifier AS INTEGER NOT NULL;
CREATE SEQUENCE category_identifier_sequence;
CREATE TABLE categories
 (category_identifier category_identifier NOT NULL PRIMARY KEY DEFAULT nextval('category_identifier_sequence'),
  title               CHARACTER VARYING NOT NULL,
  description         CHARACTER VARYING NOT NULL,
  creation_time       TIMESTAMP NOT NULL DEFAULT now());

CREATE DOMAIN topic_identifier AS INTEGER NOT NULL;
CREATE SEQUENCE topic_identifier_sequence;
CREATE TABLE topics
 (topic_identifier    topic_identifier NOT NULL PRIMARY KEY DEFAULT nextval('topic_identifier_sequence'),
  category_identifier category_identifier NOT NULL REFERENCES categories,
  title               CHARACTER VARYING NOT NULL,
  description         CHARACTER VARYING NOT NULL,
  creation_time       TIMESTAMP NOT NULL DEFAULT now(),
  created_by          user_identifier NOT NULL REFERENCES users);

CREATE DOMAIN post_identifier AS INTEGER NOT NULL;
CREATE SEQUENCE post_identifier_sequence;
CREATE TABLE posts
 (post_identifier  post_identifier NOT NULL PRIMARY KEY DEFAULT nextval('post_identifier_sequence'),
  topic_identifier topic_identifier NOT NULL REFERENCES topics,
  text             CHARACTER VARYING NOT NULL,
  creation_time    TIMESTAMP NOT NULL,
  author           user_identifier NOT NULL REFERENCES users);

CREATE TABLE read_topics
 (user_identifier  user_identifier NOT NULL REFERENCES users,
  topic_identifier topic_identifier NOT NULL REFERENCES topics,
  read_time        TIMESTAMP NOT NULL);

CREATE TABLE import_topics
 (message_id          CHARACTER VARYING NOT NULL PRIMARY KEY,
  topic_identifier    topic_identifier NOT NULL);

COMMIT TRANSACTION;
