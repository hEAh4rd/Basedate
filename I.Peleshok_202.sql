--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5


DROP DATABASE last;
--
-- Name: last; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE last WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE last OWNER TO postgres;

\connect last

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: championship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE championship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE championship_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: championship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE championship (
    id integer DEFAULT nextval('championship_id_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    host_country integer NOT NULL,
    prize_fund integer,
    CONSTRAINT championship_more CHECK ((id > 0)),
    CONSTRAINT end_date CHECK (((end_date > start_date) AND (end_date > '2012-01-02'::date))),
    CONSTRAINT host_country_check CHECK ((host_country > 0)),
    CONSTRAINT prize_fund_check CHECK ((prize_fund > 0)),
    CONSTRAINT start_date CHECK (((start_date < end_date) AND (start_date > '2012-01-01'::date)))
);


ALTER TABLE championship OWNER TO postgres;

--
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE country_id_seq OWNER TO postgres;

--
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE country (
    id integer DEFAULT nextval('country_id_seq'::regclass) NOT NULL,
    name character varying(30) NOT NULL,
    CONSTRAINT country_more CHECK ((id > 0))
);


ALTER TABLE country OWNER TO postgres;

--
-- Name: mediaprovider_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mediaprovider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mediaprovider_id_seq OWNER TO postgres;

--
-- Name: mediaprovider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE mediaprovider (
    id integer DEFAULT nextval('mediaprovider_id_seq'::regclass) NOT NULL,
    name character varying(30) NOT NULL,
    date_of_create date NOT NULL,
    CONSTRAINT date_of_create CHECK ((date_of_create > '1960-01-01'::date)),
    CONSTRAINT mediaprovider_more CHECK ((id > 0))
);


ALTER TABLE mediaprovider OWNER TO postgres;

--
-- Name: player_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE player_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE player_id_seq OWNER TO postgres;

--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE player (
    id integer DEFAULT nextval('player_id_seq'::regclass) NOT NULL,
    surname character varying(50) NOT NULL,
    alias character varying(30) NOT NULL,
    date_of_birth date NOT NULL,
    homeland integer NOT NULL,
    career_start date NOT NULL,
    team_id integer NOT NULL,
    CONSTRAINT career_start CHECK ((career_start > '2000-01-01'::date)),
    CONSTRAINT date_of_birth CHECK ((date_of_birth > '1920-01-01'::date)),
    CONSTRAINT date_of_birth_more CHECK ((date_of_birth > '1920-01-01'::date)),
    CONSTRAINT homeland_check CHECK ((homeland > 0)),
    CONSTRAINT player_more CHECK ((id > 0)),
    CONSTRAINT team_id_check CHECK ((team_id > 0))
);


ALTER TABLE player OWNER TO postgres;

--
-- Name: team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE team_id_seq OWNER TO postgres;

--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE team (
    id integer DEFAULT nextval('team_id_seq'::regclass) NOT NULL,
    name character varying(30) NOT NULL,
    founded date NOT NULL,
    country integer,
    CONSTRAINT country_check CHECK ((country > 0)),
    CONSTRAINT founded_more CHECK ((founded > '1980-01-01'::date)),
    CONSTRAINT team_more CHECK ((id > 0))
);


ALTER TABLE team OWNER TO postgres;

--
-- Name: team_mediaprovider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE team_mediaprovider (
    tid integer NOT NULL,
    mpid integer NOT NULL,
    link character varying(70) NOT NULL,
    CONSTRAINT mpid_check CHECK ((mpid > 0)),
    CONSTRAINT tid_check CHECK ((tid > 0))
);


ALTER TABLE team_mediaprovider OWNER TO postgres;

--
-- Name: teamchampionship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE teamchampionship (
    tid integer NOT NULL,
    cid integer NOT NULL,
    place_of_team integer NOT NULL,
    kush_of_team integer NOT NULL,
    CONSTRAINT champion_tid_check CHECK ((tid > 0)),
    CONSTRAINT cid_check CHECK ((cid > 0)),
    CONSTRAINT kush_of_team_check CHECK ((kush_of_team > '-1'::integer))
);


ALTER TABLE teamchampionship OWNER TO postgres;

--
-- Data for Name: championship; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO championship VALUES (1, 'ELEAGUE_Season_1', '2016-05-24', '2016-06-30', 6, 1400000);
INSERT INTO championship VALUES (2, 'StarLadder_Season_2', '2016-09-07', '2016-09-11', 1, 300000);
INSERT INTO championship VALUES (3, 'DreamHack_Masters_Malmo', '2016-04-12', '2016-04-17', 4, 250000);
INSERT INTO championship VALUES (4, 'ELEAGUE_Major', '2017-01-22', '2017-01-29', 6, 1000000);
INSERT INTO championship VALUES (5, 'ELEAGUE_Season_2', '2016-10-21', '2016-12-03', 6, 1100000);
INSERT INTO championship VALUES (6, 'DreamHack_Austin', '2016-05-06', '2016-05-08', 6, 100000);
INSERT INTO championship VALUES (7, 'ESL_One_Cologne', '2016-06-05', '2016-06-10', 7, 1000000);
INSERT INTO championship VALUES (8, 'ESL_One_New_York', '2016-09-30', '2016-10-02', 6, 250000);
INSERT INTO championship VALUES (9, 'DreamHack_Summer', '2016-07-18', '2016-07-21', 6, 100000);
INSERT INTO championship VALUES (10, 'DreamHack_Leipzig', '2016-01-22', '2016-01-24', 7, 100000);


--
-- Name: championship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('championship_id_seq', 10, true);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO country VALUES (1, 'Ukraine');
INSERT INTO country VALUES (2, 'Russia');
INSERT INTO country VALUES (3, 'Poland');
INSERT INTO country VALUES (4, 'Sweden');
INSERT INTO country VALUES (5, 'Brazil');
INSERT INTO country VALUES (6, 'USA');
INSERT INTO country VALUES (7, 'Germany');
INSERT INTO country VALUES (8, 'Netherlands');
INSERT INTO country VALUES (9, 'Canada');
INSERT INTO country VALUES (10, 'Denmark');
INSERT INTO country VALUES (11, 'France');


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('country_id_seq', 11, true);


--
-- Data for Name: mediaprovider; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO mediaprovider VALUES (1, 'Facebook', '2004-11-01');
INSERT INTO mediaprovider VALUES (2, 'Vk', '2007-01-19');
INSERT INTO mediaprovider VALUES (3, 'Instagram', '2010-10-06');
INSERT INTO mediaprovider VALUES (4, 'Youtube', '2005-02-14');
INSERT INTO mediaprovider VALUES (5, 'Twitter', '2006-03-21');


--
-- Name: mediaprovider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mediaprovider_id_seq', 5, true);


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO player VALUES (1, 'Kostyliev', 's1mple', '1997-10-02', 1, '2016-08-04', 1);
INSERT INTO player VALUES (2, 'Teslenko', 'Zeus', '1987-10-08', 1, '2017-08-09', 1);
INSERT INTO player VALUES (3, 'Vasilyev', 'flamie', '1997-04-05', 2, '2015-04-10', 1);
INSERT INTO player VALUES (4, 'Sukhariev', 'Edward', '1987-12-28', 1, '2013-12-09', 1);
INSERT INTO player VALUES (5, 'Kostin', 'seized', '1994-09-09', 2, '2013-08-20', 1);
INSERT INTO player VALUES (6, 'Wojtas', 'TaZ', '1986-06-06', 3, '2014-01-25', 2);
INSERT INTO player VALUES (7, 'Kubski', 'NEO', '1987-06-15', 3, '2014-01-25', 2);
INSERT INTO player VALUES (8, 'Jarzabkowski', 'pashaBiceps', '1988-04-11', 3, '2014-01-25', 2);
INSERT INTO player VALUES (9, 'Pogorzelski', 'Snax', '1993-06-05', 3, '2014-01-25', 2);
INSERT INTO player VALUES (10, 'Bielinski', 'byali', '1994-04-30', 3, '2014-01-25', 2);
INSERT INTO player VALUES (11, 'Johansson', 'KRiMZ', '1994-04-15', 4, '2016-10-25', 3);
INSERT INTO player VALUES (12, 'Wecksell', 'jW', '1995-02-23', 4, '2017-02-04', 3);
INSERT INTO player VALUES (13, 'R”nnquist', 'flusha', '1993-08-12', 4, '2017-02-04', 3);
INSERT INTO player VALUES (14, 'Selim', 'Golden', '1994-02-02', 4, '2017-08-20', 3);
INSERT INTO player VALUES (15, 'Olofsson', 'Lekr0', '1993-06-02', 4, '2017-08-21', 3);
INSERT INTO player VALUES (16, 'Toledo', 'FalleN', '1991-05-30', 5, '2016-07-01', 4);
INSERT INTO player VALUES (17, 'David', 'coldzera', '1994-10-31', 5, '2016-07-01', 4);
INSERT INTO player VALUES (18, 'Vasconcellos', 'felps', '1996-12-16', 5, '2017-02-05', 4);
INSERT INTO player VALUES (19, 'Alvarenga', 'fer', '1991-10-30', 5, '2016-07-01', 4);
INSERT INTO player VALUES (20, 'Pessoa', 'TACO', '1995-01-24', 5, '2016-07-01', 4);
INSERT INTO player VALUES (21, 'Cannella', 'nitr0', '1995-08-16', 6, '2015-01-13', 5);
INSERT INTO player VALUES (22, 'Jablonowski', 'EliGE', '1997-06-16', 6, '2015-03-22', 5);
INSERT INTO player VALUES (23, 'Marzano', 'jdm64', '1990-05-20', 6, '2016-06-13', 5);
INSERT INTO player VALUES (24, 'Jarguz', 'stanislaw', '1992-03-15', 6, '2017-02-03', 5);
INSERT INTO player VALUES (25, 'Dulken', 'Twistzz', '1999-11-14', 9, '2017-04-14', 5);
INSERT INTO player VALUES (26, 'MЃller', 'MICHU', '1996-03-30', 3, '2016-06-07', 6);
INSERT INTO player VALUES (27, 'Dziamalek', 'SZPERO', '1991-07-06', 3, '2016-06-07', 6);
INSERT INTO player VALUES (28, 'Karolewski', 'mouz', '1995-10-24', 3, '2016-06-07', 6);
INSERT INTO player VALUES (29, 'Rodowicz', 'rallen', '1994-07-08', 3, '2016-08-21', 6);
INSERT INTO player VALUES (30, 'Wolny', 'Hyper', '1990-03-23', 3, '2017-05-06', 6);
INSERT INTO player VALUES (31, 'Reedtz', 'dev1ce', '1995-09-08', 10, '2016-01-18', 7);
INSERT INTO player VALUES (32, 'Rothmann', 'dupreeh', '1993-03-26', 10, '2016-01-18', 7);
INSERT INTO player VALUES (33, 'Hojsleth', 'Xyp9x', '1995-09-11', 10, '2016-01-18', 7);
INSERT INTO player VALUES (34, 'Kj‘rbye', 'Kjaerbye', '1995-07-07', 10, '2016-05-19', 7);
INSERT INTO player VALUES (35, 'Rossander', 'gla1ve', '1998-04-27', 10, '2016-10-24', 7);
INSERT INTO player VALUES (36, 'Papillon', 'shox', '1992-05-27', 11, '2016-02-01', 8);
INSERT INTO player VALUES (37, 'Pianaro', 'boddy', '1997-01-08', 11, '2016-04-09', 8);
INSERT INTO player VALUES (38, 'Schmit', 'NBK', '1994-07-05', 11, '2017-02-03', 8);
INSERT INTO player VALUES (39, 'Madesclaire', 'apEX', '1993-02-22', 11, '2017-02-03', 8);
INSERT INTO player VALUES (40, 'Schrub', 'kennyS', '1995-05-19', 11, '2017-02-03', 8);


--
-- Name: player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('player_id_seq', 40, true);


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO team VALUES (1, 'Natus Vincere', '2009-03-15', 1);
INSERT INTO team VALUES (2, 'Virtus.pro', '2003-11-01', 2);
INSERT INTO team VALUES (3, 'Fnatic', '2004-06-23', 4);
INSERT INTO team VALUES (4, 'SK', '1997-03-11', 7);
INSERT INTO team VALUES (5, 'Team_Liquid', '2000-05-14', 8);
INSERT INTO team VALUES (6, 'Team_Kinguin', '2015-05-05', 3);
INSERT INTO team VALUES (7, 'Astralis', '2016-01-19', 10);
INSERT INTO team VALUES (8, 'G2', '2015-02-11', 11);


--
-- Name: team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('team_id_seq', 8, true);


--
-- Data for Name: team_mediaprovider; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO team_mediaprovider VALUES (1, 1, 'www.facebook.com/NatusVincere');
INSERT INTO team_mediaprovider VALUES (1, 2, 'vk.com/natus.vincere');
INSERT INTO team_mediaprovider VALUES (1, 3, 'www.instagram.com/natus_vincere_official');
INSERT INTO team_mediaprovider VALUES (1, 4, 'www.youtube.com/user/navicsgo');
INSERT INTO team_mediaprovider VALUES (2, 1, 'www.facebook.com/www.virtus.pro');
INSERT INTO team_mediaprovider VALUES (2, 2, 'vk.com/virtuspro');
INSERT INTO team_mediaprovider VALUES (2, 3, 'www.instagram.com/virtus.pro');
INSERT INTO team_mediaprovider VALUES (3, 1, 'www.facebook.com/fnatic/?fref=ts');
INSERT INTO team_mediaprovider VALUES (3, 3, 'www.instagram.com/fnatic');
INSERT INTO team_mediaprovider VALUES (3, 4, 'www.youtube.com/user/fnaticTV');
INSERT INTO team_mediaprovider VALUES (1, 5, 'twitter.com/natusvincere');
INSERT INTO team_mediaprovider VALUES (2, 5, 'twitter.com/Virtuspro');
INSERT INTO team_mediaprovider VALUES (3, 5, 'twitter.com/FNATIC');
INSERT INTO team_mediaprovider VALUES (4, 1, 'www.facebook.com/SKGaming');
INSERT INTO team_mediaprovider VALUES (4, 3, 'www.instagram.com/skgaming');
INSERT INTO team_mediaprovider VALUES (4, 5, 'twitter.com/skgaming');
INSERT INTO team_mediaprovider VALUES (5, 1, 'www.facebook.com/teamliquid');
INSERT INTO team_mediaprovider VALUES (5, 3, 'www.instagram.com/teamliquid');
INSERT INTO team_mediaprovider VALUES (5, 5, 'twitter.com/teamliquid');
INSERT INTO team_mediaprovider VALUES (6, 1, 'www.facebook.com/TeamKinguin');
INSERT INTO team_mediaprovider VALUES (6, 3, 'www.instagram.com/teamkinguinofficial');
INSERT INTO team_mediaprovider VALUES (6, 4, 'www.youtube.com/user/OfficialKinguin');
INSERT INTO team_mediaprovider VALUES (6, 5, 'twitter.com/teamkinguin');
INSERT INTO team_mediaprovider VALUES (7, 1, 'www.facebook.com/astralisgg');
INSERT INTO team_mediaprovider VALUES (7, 3, 'www.instagram.com/astralisgg');
INSERT INTO team_mediaprovider VALUES (7, 4, 'twitter.com/astralisgg');
INSERT INTO team_mediaprovider VALUES (8, 1, 'www.facebook.com/g2esports');
INSERT INTO team_mediaprovider VALUES (8, 3, 'www.instagram.com/g2esports');
INSERT INTO team_mediaprovider VALUES (8, 4, 'www.youtube.com/g2esports');
INSERT INTO team_mediaprovider VALUES (8, 5, 'twitter.com/g2esports');


--
-- Data for Name: teamchampionship; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO teamchampionship VALUES (1, 1, 4, 70000);
INSERT INTO teamchampionship VALUES (2, 1, 1, 400000);
INSERT INTO teamchampionship VALUES (3, 1, 2, 140000);
INSERT INTO teamchampionship VALUES (4, 1, 21, 30000);
INSERT INTO teamchampionship VALUES (1, 2, 13, 0);
INSERT INTO teamchampionship VALUES (2, 2, 14, 0);
INSERT INTO teamchampionship VALUES (1, 3, 2, 50000);
INSERT INTO teamchampionship VALUES (2, 3, 8, 10000);
INSERT INTO teamchampionship VALUES (7, 1, 5, 50000);
INSERT INTO teamchampionship VALUES (8, 1, 13, 40000);
INSERT INTO teamchampionship VALUES (8, 2, 2, 100000);
INSERT INTO teamchampionship VALUES (7, 2, 5, 20000);
INSERT INTO teamchampionship VALUES (7, 3, 11, 2000);
INSERT INTO teamchampionship VALUES (8, 3, 14, 2000);
INSERT INTO teamchampionship VALUES (7, 4, 1, 500000);
INSERT INTO teamchampionship VALUES (2, 4, 2, 150000);
INSERT INTO teamchampionship VALUES (3, 4, 3, 70000);
INSERT INTO teamchampionship VALUES (4, 4, 4, 70000);
INSERT INTO teamchampionship VALUES (1, 4, 5, 35000);
INSERT INTO teamchampionship VALUES (5, 4, 9, 8750);
INSERT INTO teamchampionship VALUES (8, 4, 12, 8750);
INSERT INTO teamchampionship VALUES (6, 4, 13, 8750);
INSERT INTO teamchampionship VALUES (7, 5, 2, 140000);
INSERT INTO teamchampionship VALUES (4, 5, 3, 60000);
INSERT INTO teamchampionship VALUES (2, 5, 5, 50000);
INSERT INTO teamchampionship VALUES (8, 5, 10, 30000);
INSERT INTO teamchampionship VALUES (3, 5, 11, 30000);
INSERT INTO teamchampionship VALUES (5, 6, 3, 10000);
INSERT INTO teamchampionship VALUES (4, 7, 1, 500000);
INSERT INTO teamchampionship VALUES (5, 7, 2, 150000);
INSERT INTO teamchampionship VALUES (3, 7, 3, 70000);
INSERT INTO teamchampionship VALUES (2, 7, 4, 70000);
INSERT INTO teamchampionship VALUES (7, 7, 5, 35000);
INSERT INTO teamchampionship VALUES (1, 7, 8, 35000);
INSERT INTO teamchampionship VALUES (6, 7, 12, 8750);
INSERT INTO teamchampionship VALUES (8, 7, 15, 8750);
INSERT INTO teamchampionship VALUES (1, 8, 1, 125000);
INSERT INTO teamchampionship VALUES (2, 8, 2, 50000);
INSERT INTO teamchampionship VALUES (5, 8, 3, 25000);
INSERT INTO teamchampionship VALUES (4, 8, 4, 25000);
INSERT INTO teamchampionship VALUES (3, 8, 5, 8500);
INSERT INTO teamchampionship VALUES (7, 8, 7, 5000);
INSERT INTO teamchampionship VALUES (8, 8, 8, 3000);
INSERT INTO teamchampionship VALUES (7, 9, 3, 10000);
INSERT INTO teamchampionship VALUES (1, 10, 1, 50000);
INSERT INTO teamchampionship VALUES (7, 10, 4, 10000);
INSERT INTO teamchampionship VALUES (4, 10, 7, 2000);
INSERT INTO teamchampionship VALUES (2, 10, 8, 2000);
INSERT INTO teamchampionship VALUES (1, 5, 9, 30000);
INSERT INTO teamchampionship VALUES (5, 3, 13, 2000);
INSERT INTO teamchampionship VALUES (4, 9, 5, 3000);
INSERT INTO teamchampionship VALUES (5, 1, 23, 30000);


--
-- Name: championship championship_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY championship
    ADD CONSTRAINT championship_name_key UNIQUE (name);


--
-- Name: championship championship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY championship
    ADD CONSTRAINT championship_pkey PRIMARY KEY (id);


--
-- Name: country country_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_name_key UNIQUE (name);


--
-- Name: country country_name_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_name_key1 UNIQUE (name);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: mediaprovider mediaprovider_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mediaprovider
    ADD CONSTRAINT mediaprovider_name_key UNIQUE (name);


--
-- Name: mediaprovider mediaprovider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mediaprovider
    ADD CONSTRAINT mediaprovider_pkey PRIMARY KEY (id);


--
-- Name: player player_alias_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_alias_key UNIQUE (alias);


--
-- Name: player player_full_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_full_name_key UNIQUE (surname);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_pkey PRIMARY KEY (id);


--
-- Name: team_mediaprovider team_mediaprovider_link_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team_mediaprovider
    ADD CONSTRAINT team_mediaprovider_link_key UNIQUE (link);


--
-- Name: team_mediaprovider team_mediaprovider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team_mediaprovider
    ADD CONSTRAINT team_mediaprovider_pkey PRIMARY KEY (tid, mpid);


--
-- Name: team team_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team
    ADD CONSTRAINT team_name_key UNIQUE (name);


--
-- Name: team team_name_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team
    ADD CONSTRAINT team_name_key1 UNIQUE (name);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: teamchampionship teamchampionship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teamchampionship
    ADD CONSTRAINT teamchampionship_pkey PRIMARY KEY (tid, cid);


--
-- Name: championship championship_host_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY championship
    ADD CONSTRAINT championship_host_country_fkey FOREIGN KEY (host_country) REFERENCES country(id);


--
-- Name: player player_homeland_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_homeland_fkey FOREIGN KEY (homeland) REFERENCES country(id);


--
-- Name: player player_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_team_id_fkey FOREIGN KEY (team_id) REFERENCES team(id);


--
-- Name: team team_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team
    ADD CONSTRAINT team_country_fkey FOREIGN KEY (country) REFERENCES country(id);


--
-- Name: team_mediaprovider team_mediaprovider_mpid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team_mediaprovider
    ADD CONSTRAINT team_mediaprovider_mpid_fkey FOREIGN KEY (mpid) REFERENCES mediaprovider(id);


--
-- Name: team_mediaprovider team_mediaprovider_tid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team_mediaprovider
    ADD CONSTRAINT team_mediaprovider_tid_fkey FOREIGN KEY (tid) REFERENCES team(id);


--
-- Name: teamchampionship teamchampionship_cid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teamchampionship
    ADD CONSTRAINT teamchampionship_cid_fkey FOREIGN KEY (cid) REFERENCES championship(id);


--
-- Name: teamchampionship teamchampionship_tid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teamchampionship
    ADD CONSTRAINT teamchampionship_tid_fkey FOREIGN KEY (tid) REFERENCES team(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

