--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: restaurant; Type: TABLE; Schema: public; Owner: jetrodriguez
--

CREATE TABLE restaurant (
    id integer NOT NULL,
    name character varying,
    address character varying,
    category character varying
);


ALTER TABLE restaurant OWNER TO jetrodriguez;

--
-- Name: restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: jetrodriguez
--

CREATE SEQUENCE restaurant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE restaurant_id_seq OWNER TO jetrodriguez;

--
-- Name: restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jetrodriguez
--

ALTER SEQUENCE restaurant_id_seq OWNED BY restaurant.id;


--
-- Name: review; Type: TABLE; Schema: public; Owner: jetrodriguez
--

CREATE TABLE review (
    id integer NOT NULL,
    reviewer_id integer,
    stars integer,
    title character varying,
    review character varying,
    restaurant_id integer,
    CONSTRAINT review_stars_check CHECK ((stars >= 1)),
    CONSTRAINT review_stars_check1 CHECK ((stars <= 5))
);


ALTER TABLE review OWNER TO jetrodriguez;

--
-- Name: review_id_seq; Type: SEQUENCE; Schema: public; Owner: jetrodriguez
--

CREATE SEQUENCE review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE review_id_seq OWNER TO jetrodriguez;

--
-- Name: review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jetrodriguez
--

ALTER SEQUENCE review_id_seq OWNED BY review.id;


--
-- Name: reviewer; Type: TABLE; Schema: public; Owner: jetrodriguez
--

CREATE TABLE reviewer (
    id integer NOT NULL,
    name character varying,
    email character varying,
    karma integer DEFAULT 0,
    CONSTRAINT reviewer_karma_check CHECK ((karma <= 7)),
    CONSTRAINT reviewer_karma_check1 CHECK ((karma >= 0))
);


ALTER TABLE reviewer OWNER TO jetrodriguez;

--
-- Name: reviewer_id_seq; Type: SEQUENCE; Schema: public; Owner: jetrodriguez
--

CREATE SEQUENCE reviewer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reviewer_id_seq OWNER TO jetrodriguez;

--
-- Name: reviewer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jetrodriguez
--

ALTER SEQUENCE reviewer_id_seq OWNED BY reviewer.id;


--
-- Name: restaurant id; Type: DEFAULT; Schema: public; Owner: jetrodriguez
--

ALTER TABLE ONLY restaurant ALTER COLUMN id SET DEFAULT nextval('restaurant_id_seq'::regclass);


--
-- Name: review id; Type: DEFAULT; Schema: public; Owner: jetrodriguez
--

ALTER TABLE ONLY review ALTER COLUMN id SET DEFAULT nextval('review_id_seq'::regclass);


--
-- Name: reviewer id; Type: DEFAULT; Schema: public; Owner: jetrodriguez
--

ALTER TABLE ONLY reviewer ALTER COLUMN id SET DEFAULT nextval('reviewer_id_seq'::regclass);


--
-- Data for Name: restaurant; Type: TABLE DATA; Schema: public; Owner: jetrodriguez
--

COPY restaurant (id, name, address, category) FROM stdin;
1	Chili's	332 Main	American
2	Wang's	331 Main	Chinese
3	Big Bob's	330 Main	BBQ
4	Don Julio's	333Main	Mexican
5	El Reymundo	300 Main	Mexican
6	Jack's Cheese	299 Main	American
7	Some Orange Chicken	298 Main	Chinese
8	Corleone's	297 Main	Italian
9	That Damn Hamburger	296 Main	American
10	Nespress	295 Main	Coffee
11	sdsf	dfdsf	dsfsa
12	qwere	ereeeee	ewrw
13	qwere	ereeeee	ewrw
14	qwere	ereeeee	ewrw
15	wertet	fggg	dtyu
16	sdfdfs	aaaaaa	aadf
17	asdfds	dff	aaadf
18	asdf	hjjh	gggg
19	A	nother	test
20	A	nother	test
21	A	nother	test
\.


--
-- Name: restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jetrodriguez
--

SELECT pg_catalog.setval('restaurant_id_seq', 21, true);


--
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: jetrodriguez
--

COPY review (id, reviewer_id, stars, title, review, restaurant_id) FROM stdin;
1	1	2	Chilis is meh	typical chain stuff	1
2	1	3	Big Bobs is solid	big bobs bbq is cool, not great	3
3	1	4	el reymundos woo	el reymundos got  a 4	5
4	1	2	chinese at cheap	ok it was ok	7
5	1	5	OMG BEST BURGER	blown away by the fries	9
6	2	3	solid chinese	i liked it	2
7	2	4	enchiladas at dJ	nice tequila n stuff	4
8	2	4	never knw chz so good 	the stringiest	6
9	2	5	ive only had this italian	wow i live spaghettis	8
10	2	2	my coffee was cold	i didnt know iced meant it was cold???	10
11	3	4	Big BOb's...dank	we got the meats	3
12	3	2	who does that? why cheese only?	they should at leas add wine to the menu.	6
13	3	5	BEST BURGER	the burgers were juicy the fries were crisp	9
14	3	3	solid outing	food was ayt	4
15	3	5	el rey is best	best chips and salsa 	5
16	\N	3	tes	dsfdsfdfsad	7
17	\N	3	tes	dsfdsfdfsad	7
\.


--
-- Name: review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jetrodriguez
--

SELECT pg_catalog.setval('review_id_seq', 17, true);


--
-- Data for Name: reviewer; Type: TABLE DATA; Schema: public; Owner: jetrodriguez
--

COPY reviewer (id, name, email, karma) FROM stdin;
3	anon_hackR	anon_hackR@food.com	0
2	SpongeBob	spongebob@food.com	7
1	Brett	brett@food.com	4
\.


--
-- Name: reviewer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jetrodriguez
--

SELECT pg_catalog.setval('reviewer_id_seq', 3, true);


--
-- Name: restaurant restaurant_pkey; Type: CONSTRAINT; Schema: public; Owner: jetrodriguez
--

ALTER TABLE ONLY restaurant
    ADD CONSTRAINT restaurant_pkey PRIMARY KEY (id);


--
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: jetrodriguez
--

ALTER TABLE ONLY review
    ADD CONSTRAINT review_pkey PRIMARY KEY (id);


--
-- Name: reviewer reviewer_pkey; Type: CONSTRAINT; Schema: public; Owner: jetrodriguez
--

ALTER TABLE ONLY reviewer
    ADD CONSTRAINT reviewer_pkey PRIMARY KEY (id);


--
-- Name: review review_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jetrodriguez
--

ALTER TABLE ONLY review
    ADD CONSTRAINT review_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES restaurant(id);


--
-- Name: review review_reviewer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jetrodriguez
--

ALTER TABLE ONLY review
    ADD CONSTRAINT review_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES reviewer(id);


--
-- PostgreSQL database dump complete
--

