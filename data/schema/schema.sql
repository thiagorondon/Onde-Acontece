--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.seguranca_ocorrencias DROP CONSTRAINT seguranca_ocorrencias_municipio_id_fkey;
ALTER TABLE ONLY public.ocorrencia_municipios DROP CONSTRAINT ocorrencia_municipios_ocorrencia_id_fkey;
ALTER TABLE ONLY public.ocorrencia_municipios DROP CONSTRAINT ocorrencia_municipios_municipio_id_fkey;
ALTER TABLE ONLY public.municipios DROP CONSTRAINT municipios_estado_id_fkey;
ALTER TABLE ONLY public.municipio_maps DROP CONSTRAINT municipio_maps_municipio_id_fkey;
DROP INDEX public.seguranca_ocorrencias_idx_municipio_id;
DROP INDEX public.ocorrencia_municipios_idx_ocorrencia_id;
DROP INDEX public.ocorrencia_municipios_idx_municipio_id;
DROP INDEX public.municipios_idx_estado_id;
DROP INDEX public.municipio_maps_idx_municipio_id;
ALTER TABLE ONLY public.seguranca_ocorrencias DROP CONSTRAINT seguranca_ocorrencias_pkey;
ALTER TABLE ONLY public.ocorrencias DROP CONSTRAINT ocorrencias_pkey;
ALTER TABLE ONLY public.municipios DROP CONSTRAINT municipios_pkey;
ALTER TABLE ONLY public.municipios DROP CONSTRAINT municipios_nome_estado_id;
ALTER TABLE ONLY public.municipio_maps DROP CONSTRAINT municipio_maps_pkey;
ALTER TABLE ONLY public.municipio_ibges DROP CONSTRAINT municipio_ibges_pkey;
ALTER TABLE ONLY public.estadoes DROP CONSTRAINT estadoes_pkey;
ALTER TABLE public.seguranca_ocorrencias ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.ocorrencias ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.municipios ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.municipio_maps ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.municipio_ibges ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.estadoes ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.seguranca_ocorrencias_id_seq;
DROP TABLE public.seguranca_ocorrencias;
DROP TABLE public.raw_indicadores_ssprs_municipioss;
DROP SEQUENCE public.ocorrencias_id_seq;
DROP TABLE public.ocorrencias;
DROP TABLE public.ocorrencia_municipios;
DROP SEQUENCE public.municipios_id_seq;
DROP TABLE public.municipios;
DROP SEQUENCE public.municipio_maps_id_seq;
DROP TABLE public.municipio_maps;
DROP SEQUENCE public.municipio_ibges_id_seq;
DROP TABLE public.municipio_ibges;
DROP SEQUENCE public.estadoes_id_seq;
DROP TABLE public.estadoes;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: estadoes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE estadoes (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    sigla character(2) NOT NULL
);


--
-- Name: estadoes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE estadoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estadoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE estadoes_id_seq OWNED BY estadoes.id;


--
-- Name: municipio_ibges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE municipio_ibges (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    valor character varying(255) NOT NULL
);


--
-- Name: municipio_ibges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE municipio_ibges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: municipio_ibges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE municipio_ibges_id_seq OWNED BY municipio_ibges.id;


--
-- Name: municipio_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE municipio_maps (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    municipio_id integer NOT NULL
);


--
-- Name: municipio_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE municipio_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: municipio_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE municipio_maps_id_seq OWNED BY municipio_maps.id;


--
-- Name: municipios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE municipios (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    estado_id integer NOT NULL,
    the_geom geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((st_srid(the_geom) = (-1)))
);


--
-- Name: municipios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE municipios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: municipios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE municipios_id_seq OWNED BY municipios.id;


--
-- Name: ocorrencia_municipios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ocorrencia_municipios (
    ocorrencia_id integer NOT NULL,
    municipio_id integer NOT NULL,
    quant integer NOT NULL,
    ano integer NOT NULL
);


--
-- Name: ocorrencias; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ocorrencias (
    id integer NOT NULL,
    tipo character varying(255) NOT NULL
);


--
-- Name: ocorrencias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ocorrencias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ocorrencias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ocorrencias_id_seq OWNED BY ocorrencias.id;


--
-- Name: raw_indicadores_ssprs_municipioss; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE raw_indicadores_ssprs_municipioss (
    municipio character varying(255) NOT NULL,
    homicidio integer NOT NULL,
    furtos_veiculo integer NOT NULL,
    furtos integer NOT NULL,
    roubos integer NOT NULL,
    latrocionio integer NOT NULL,
    roubo_veiculo integer NOT NULL,
    extorsao integer NOT NULL,
    extorsao_sequesto integer NOT NULL,
    estelionato integer NOT NULL,
    delitos_corrupcao integer NOT NULL,
    posse_entorpecente integer NOT NULL,
    delitos_municoes integer NOT NULL,
    trafico_entorpecente integer NOT NULL,
    ano integer NOT NULL
);


--
-- Name: seguranca_ocorrencias; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE seguranca_ocorrencias (
    id integer NOT NULL,
    municipio_id bigint NOT NULL,
    periodo smallint NOT NULL,
    tipo character varying(255) NOT NULL,
    ocorrencias bigint NOT NULL
);


--
-- Name: seguranca_ocorrencias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seguranca_ocorrencias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seguranca_ocorrencias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE seguranca_ocorrencias_id_seq OWNED BY seguranca_ocorrencias.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE estadoes ALTER COLUMN id SET DEFAULT nextval('estadoes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE municipio_ibges ALTER COLUMN id SET DEFAULT nextval('municipio_ibges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE municipio_maps ALTER COLUMN id SET DEFAULT nextval('municipio_maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE municipios ALTER COLUMN id SET DEFAULT nextval('municipios_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ocorrencias ALTER COLUMN id SET DEFAULT nextval('ocorrencias_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE seguranca_ocorrencias ALTER COLUMN id SET DEFAULT nextval('seguranca_ocorrencias_id_seq'::regclass);


--
-- Name: estadoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY estadoes
    ADD CONSTRAINT estadoes_pkey PRIMARY KEY (id);


--
-- Name: municipio_ibges_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY municipio_ibges
    ADD CONSTRAINT municipio_ibges_pkey PRIMARY KEY (id);


--
-- Name: municipio_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY municipio_maps
    ADD CONSTRAINT municipio_maps_pkey PRIMARY KEY (id);


--
-- Name: municipios_nome_estado_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY municipios
    ADD CONSTRAINT municipios_nome_estado_id UNIQUE (nome, estado_id);


--
-- Name: municipios_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY municipios
    ADD CONSTRAINT municipios_pkey PRIMARY KEY (id);


--
-- Name: ocorrencias_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ocorrencias
    ADD CONSTRAINT ocorrencias_pkey PRIMARY KEY (id);


--
-- Name: seguranca_ocorrencias_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY seguranca_ocorrencias
    ADD CONSTRAINT seguranca_ocorrencias_pkey PRIMARY KEY (id);


--
-- Name: municipio_maps_idx_municipio_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX municipio_maps_idx_municipio_id ON municipio_maps USING btree (municipio_id);


--
-- Name: municipios_idx_estado_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX municipios_idx_estado_id ON municipios USING btree (estado_id);


--
-- Name: ocorrencia_municipios_idx_municipio_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX ocorrencia_municipios_idx_municipio_id ON ocorrencia_municipios USING btree (municipio_id);


--
-- Name: ocorrencia_municipios_idx_ocorrencia_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX ocorrencia_municipios_idx_ocorrencia_id ON ocorrencia_municipios USING btree (ocorrencia_id);


--
-- Name: seguranca_ocorrencias_idx_municipio_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX seguranca_ocorrencias_idx_municipio_id ON seguranca_ocorrencias USING btree (municipio_id);


--
-- Name: municipio_maps_municipio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY municipio_maps
    ADD CONSTRAINT municipio_maps_municipio_id_fkey FOREIGN KEY (municipio_id) REFERENCES municipios(id) DEFERRABLE;


--
-- Name: municipios_estado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY municipios
    ADD CONSTRAINT municipios_estado_id_fkey FOREIGN KEY (estado_id) REFERENCES state(gid) DEFERRABLE;


--
-- Name: ocorrencia_municipios_municipio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_municipios
    ADD CONSTRAINT ocorrencia_municipios_municipio_id_fkey FOREIGN KEY (municipio_id) REFERENCES municipios(id) DEFERRABLE;


--
-- Name: ocorrencia_municipios_ocorrencia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ocorrencia_municipios
    ADD CONSTRAINT ocorrencia_municipios_ocorrencia_id_fkey FOREIGN KEY (ocorrencia_id) REFERENCES ocorrencias(id) DEFERRABLE;


--
-- Name: seguranca_ocorrencias_municipio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY seguranca_ocorrencias
    ADD CONSTRAINT seguranca_ocorrencias_municipio_id_fkey FOREIGN KEY (municipio_id) REFERENCES municipios(id) DEFERRABLE;


CREATE TABLE raw_ibge_censo (
  cidade varchar(255) not null,
  descricao varchar(255) not null,
  unidade varchar(255) not null,
  valor float
);

create table municipio_censo (
  municipio_id integer not null,
  descricao varchar(255) not null,
  valor float,
  unidade varchar(255) not null,
  foreign key (municipio_id) references municipios(id)
);

--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;

--
-- PostgreSQL database dump complete
--

