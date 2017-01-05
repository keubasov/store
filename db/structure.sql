--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.5
-- Dumped by pg_dump version 9.5.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: bedclothes_material; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE bedclothes_material AS ENUM (
    'unbleached_calico',
    'poplin',
    'sateen'
);


--
-- Name: bedclothes_size; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE bedclothes_size AS ENUM (
    'one_half',
    'two',
    'two_euro',
    'euro',
    'family'
);


--
-- Name: product_types; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE product_types AS ENUM (
    'bedclothe',
    'blanket',
    'pillow',
    'towel',
    'matress'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: looks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE looks (
    id integer NOT NULL,
    name character varying,
    description text,
    product_type product_types DEFAULT 'bedclothe'::product_types NOT NULL
);


--
-- Name: looks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE looks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: looks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE looks_id_seq OWNED BY looks.id;


--
-- Name: product_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE product_images (
    id integer NOT NULL,
    look_id integer,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone
);


--
-- Name: product_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_images_id_seq OWNED BY product_images.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE products (
    id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    price money NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    look_id integer,
    b_size bedclothes_size,
    b_material bedclothes_material
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY looks ALTER COLUMN id SET DEFAULT nextval('looks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_images ALTER COLUMN id SET DEFAULT nextval('product_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: looks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY looks
    ADD CONSTRAINT looks_pkey PRIMARY KEY (id);


--
-- Name: product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_product_images_on_look_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_images_on_look_id ON product_images USING btree (look_id);


--
-- Name: index_products_on_look_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_look_id ON products USING btree (look_id);


--
-- Name: fk_rails_53ec856160; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY products
    ADD CONSTRAINT fk_rails_53ec856160 FOREIGN KEY (look_id) REFERENCES looks(id);


--
-- Name: fk_rails_c7ebd19dd5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_images
    ADD CONSTRAINT fk_rails_c7ebd19dd5 FOREIGN KEY (look_id) REFERENCES looks(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES
('20170104050338'),
('20170104050438'),
('20170104050509'),
('20170104050710');


