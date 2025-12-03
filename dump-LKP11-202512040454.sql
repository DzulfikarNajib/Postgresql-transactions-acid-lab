--
-- PostgreSQL database dump
--

\restrict sjdf0bZcgfyL2cM39Exhh9fcsSU4WEIaboWmIgIEXaaQ4ENNm0z3gOYQE1G45zh

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-04 04:54:29

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16752)
-- Name: lab_simple; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lab_simple;


ALTER SCHEMA lab_simple OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16806)
-- Name: accounts; Type: TABLE; Schema: lab_simple; Owner: postgres
--

CREATE TABLE lab_simple.accounts (
    id integer NOT NULL,
    owner text NOT NULL,
    balance numeric(12,2) NOT NULL,
    CONSTRAINT accounts_balance_check CHECK ((balance >= (0)::numeric))
);


ALTER TABLE lab_simple.accounts OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16805)
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: lab_simple; Owner: postgres
--

CREATE SEQUENCE lab_simple.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_simple.accounts_id_seq OWNER TO postgres;

--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 225
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: lab_simple; Owner: postgres
--

ALTER SEQUENCE lab_simple.accounts_id_seq OWNED BY lab_simple.accounts.id;


--
-- TOC entry 224 (class 1259 OID 16780)
-- Name: order_items; Type: TABLE; Schema: lab_simple; Owner: postgres
--

CREATE TABLE lab_simple.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    sku text NOT NULL,
    qty integer NOT NULL,
    price numeric(12,2) NOT NULL,
    CONSTRAINT order_items_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT order_items_qty_check CHECK ((qty > 0))
);


ALTER TABLE lab_simple.order_items OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16779)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: lab_simple; Owner: postgres
--

CREATE SEQUENCE lab_simple.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_simple.order_items_id_seq OWNER TO postgres;

--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 223
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: lab_simple; Owner: postgres
--

ALTER SEQUENCE lab_simple.order_items_id_seq OWNED BY lab_simple.order_items.id;


--
-- TOC entry 222 (class 1259 OID 16765)
-- Name: orders; Type: TABLE; Schema: lab_simple; Owner: postgres
--

CREATE TABLE lab_simple.orders (
    id integer NOT NULL,
    customer text NOT NULL,
    status text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT orders_status_check CHECK ((status = ANY (ARRAY['NEW'::text, 'PAID'::text, 'CANCELLED'::text])))
);


ALTER TABLE lab_simple.orders OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16764)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: lab_simple; Owner: postgres
--

CREATE SEQUENCE lab_simple.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lab_simple.orders_id_seq OWNER TO postgres;

--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 221
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: lab_simple; Owner: postgres
--

ALTER SEQUENCE lab_simple.orders_id_seq OWNED BY lab_simple.orders.id;


--
-- TOC entry 220 (class 1259 OID 16753)
-- Name: stock; Type: TABLE; Schema: lab_simple; Owner: postgres
--

CREATE TABLE lab_simple.stock (
    sku text NOT NULL,
    name text NOT NULL,
    qty integer NOT NULL,
    CONSTRAINT stock_qty_check CHECK ((qty >= 0))
);


ALTER TABLE lab_simple.stock OWNER TO postgres;

--
-- TOC entry 4874 (class 2604 OID 16809)
-- Name: accounts id; Type: DEFAULT; Schema: lab_simple; Owner: postgres
--

ALTER TABLE ONLY lab_simple.accounts ALTER COLUMN id SET DEFAULT nextval('lab_simple.accounts_id_seq'::regclass);


--
-- TOC entry 4873 (class 2604 OID 16783)
-- Name: order_items id; Type: DEFAULT; Schema: lab_simple; Owner: postgres
--

ALTER TABLE ONLY lab_simple.order_items ALTER COLUMN id SET DEFAULT nextval('lab_simple.order_items_id_seq'::regclass);


--
-- TOC entry 4871 (class 2604 OID 16768)
-- Name: orders id; Type: DEFAULT; Schema: lab_simple; Owner: postgres
--

ALTER TABLE ONLY lab_simple.orders ALTER COLUMN id SET DEFAULT nextval('lab_simple.orders_id_seq'::regclass);


--
-- TOC entry 5043 (class 0 OID 16806)
-- Dependencies: 226
-- Data for Name: accounts; Type: TABLE DATA; Schema: lab_simple; Owner: postgres
--

INSERT INTO lab_simple.accounts VALUES (2, 'Bob', 550.00);
INSERT INTO lab_simple.accounts VALUES (1, 'Alice', 1025.00);


--
-- TOC entry 5041 (class 0 OID 16780)
-- Dependencies: 224
-- Data for Name: order_items; Type: TABLE DATA; Schema: lab_simple; Owner: postgres
--

INSERT INTO lab_simple.order_items VALUES (1, 1, 'SKU-01', 5, 30000.00);


--
-- TOC entry 5039 (class 0 OID 16765)
-- Dependencies: 222
-- Data for Name: orders; Type: TABLE DATA; Schema: lab_simple; Owner: postgres
--

INSERT INTO lab_simple.orders VALUES (1, 'Rina', 'NEW', '2025-11-06 16:11:43.455068');


--
-- TOC entry 5037 (class 0 OID 16753)
-- Dependencies: 220
-- Data for Name: stock; Type: TABLE DATA; Schema: lab_simple; Owner: postgres
--

INSERT INTO lab_simple.stock VALUES ('SKU-02', 'Keyboard', 3);
INSERT INTO lab_simple.stock VALUES ('SKU-03', 'Laptop', 20);
INSERT INTO lab_simple.stock VALUES ('SKU-01', 'USB Cable', 5);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 225
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: lab_simple; Owner: postgres
--

SELECT pg_catalog.setval('lab_simple.accounts_id_seq', 2, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 223
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: lab_simple; Owner: postgres
--

SELECT pg_catalog.setval('lab_simple.order_items_id_seq', 3, true);


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 221
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: lab_simple; Owner: postgres
--

SELECT pg_catalog.setval('lab_simple.orders_id_seq', 2, true);


--
-- TOC entry 4887 (class 2606 OID 16817)
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: lab_simple; Owner: postgres
--

ALTER TABLE ONLY lab_simple.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- TOC entry 4885 (class 2606 OID 16794)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: lab_simple; Owner: postgres
--

ALTER TABLE ONLY lab_simple.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4883 (class 2606 OID 16778)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: lab_simple; Owner: postgres
--

ALTER TABLE ONLY lab_simple.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4881 (class 2606 OID 16763)
-- Name: stock stock_pkey; Type: CONSTRAINT; Schema: lab_simple; Owner: postgres
--

ALTER TABLE ONLY lab_simple.stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (sku);


--
-- TOC entry 4888 (class 2606 OID 16795)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: lab_simple; Owner: postgres
--

ALTER TABLE ONLY lab_simple.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES lab_simple.orders(id) ON DELETE CASCADE;


--
-- TOC entry 4889 (class 2606 OID 16800)
-- Name: order_items order_items_sku_fkey; Type: FK CONSTRAINT; Schema: lab_simple; Owner: postgres
--

ALTER TABLE ONLY lab_simple.order_items
    ADD CONSTRAINT order_items_sku_fkey FOREIGN KEY (sku) REFERENCES lab_simple.stock(sku);


-- Completed on 2025-12-04 04:54:30

--
-- PostgreSQL database dump complete
--

\unrestrict sjdf0bZcgfyL2cM39Exhh9fcsSU4WEIaboWmIgIEXaaQ4ENNm0z3gOYQE1G45zh

