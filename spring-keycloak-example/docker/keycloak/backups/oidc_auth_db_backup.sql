--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18
-- Dumped by pg_dump version 15.13 (Ubuntu 15.13-1.pgdg20.04+1)

-- Started on 2025-08-03 16:51:45 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4281 (class 1262 OID 16384)
-- Name: oidc_auth_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE oidc_auth_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';

ALTER DATABASE oidc_auth_db OWNER TO postgres;

\connect oidc_auth_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4282 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 243 (class 1259 OID 17017)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 17460)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 17032)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17027)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17022)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17037)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 17475)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16398)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16756)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 17724)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 17599)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16766)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17265)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 17279)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 17765)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17284)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 17520)
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 17515)
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16417)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16420)
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16390)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16385)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 17781)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16425)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 17480)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 17485)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 17807)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 17494)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 17503)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 17506)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 17512)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16802)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 17577)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 17204)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17201)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16807)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16816)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16920)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16925)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 18006)
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 17198)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL,
    description character varying(255)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16433)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16917)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17189)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17184)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 17969)
-- Name: org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 17980)
-- Name: org_domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 17403)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16791)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16797)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16439)
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16456)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 17213)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16909)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16464)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 17915)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16467)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16474)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16825)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16484)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17148)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 17141)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 17846)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 17430)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 17415)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 17353)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 17822)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 17389)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 17361)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 17375)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 17864)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 17997)
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 17874)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16487)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 17445)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 18013)
-- Name: server_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16493)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16930)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 17797)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16498)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16506)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17042)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17047)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16511)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17210)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16516)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16519)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16533)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- TOC entry 4222 (class 0 OID 17017)
-- Dependencies: 243
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4249 (class 0 OID 17460)
-- Dependencies: 270
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4225 (class 0 OID 17032)
-- Dependencies: 246
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authentication_execution VALUES ('0b0d1942-2f06-49ab-88a5-a55aa5e39ccf', NULL, 'auth-cookie', 'da831425-93a2-4023-b385-9915e55fffcf', '4637261a-0c87-427e-9bd2-99dd6fbcccc6', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('087aea09-3710-4c19-94d3-468f14c89eb2', NULL, 'auth-spnego', 'da831425-93a2-4023-b385-9915e55fffcf', '4637261a-0c87-427e-9bd2-99dd6fbcccc6', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('fc0a4e1c-9212-4471-9ef7-6e5d7d3b4291', NULL, 'identity-provider-redirector', 'da831425-93a2-4023-b385-9915e55fffcf', '4637261a-0c87-427e-9bd2-99dd6fbcccc6', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d7084733-b017-487a-a788-ce1e017c17a5', NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', '4637261a-0c87-427e-9bd2-99dd6fbcccc6', 2, 30, true, '237effd1-207d-4355-a77a-ff3f37118718', NULL);
INSERT INTO public.authentication_execution VALUES ('b600b995-9cb8-46fd-a879-ddc1c012a805', NULL, 'auth-username-password-form', 'da831425-93a2-4023-b385-9915e55fffcf', '237effd1-207d-4355-a77a-ff3f37118718', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ab8ad1dd-4410-4cb0-aecc-2ed4b302841c', NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', '237effd1-207d-4355-a77a-ff3f37118718', 1, 20, true, '3d73ccfa-eca3-48b1-bab1-2c4a8e7dcd15', NULL);
INSERT INTO public.authentication_execution VALUES ('6f7bd4ad-397e-47a3-b9b3-f30ba8a10d03', NULL, 'conditional-user-configured', 'da831425-93a2-4023-b385-9915e55fffcf', '3d73ccfa-eca3-48b1-bab1-2c4a8e7dcd15', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6e2eba4d-ed57-4afa-9927-8a21630f04d2', NULL, 'auth-otp-form', 'da831425-93a2-4023-b385-9915e55fffcf', '3d73ccfa-eca3-48b1-bab1-2c4a8e7dcd15', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ac5a2bf9-452d-46ea-9dd1-984dc20ba82a', NULL, 'webauthn-authenticator', 'da831425-93a2-4023-b385-9915e55fffcf', '3d73ccfa-eca3-48b1-bab1-2c4a8e7dcd15', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('7134be31-091d-4373-9303-538c042e82dd', NULL, 'auth-recovery-authn-code-form', 'da831425-93a2-4023-b385-9915e55fffcf', '3d73ccfa-eca3-48b1-bab1-2c4a8e7dcd15', 3, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a85f9c86-a09b-4a14-8652-9f378c1bf92d', NULL, 'direct-grant-validate-username', 'da831425-93a2-4023-b385-9915e55fffcf', '9e0b1e34-f06d-435e-955e-94d32ae75d82', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6d87bf0c-0b1f-42c2-a4f6-ef56f3bf2c58', NULL, 'direct-grant-validate-password', 'da831425-93a2-4023-b385-9915e55fffcf', '9e0b1e34-f06d-435e-955e-94d32ae75d82', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f6ea84f6-fa1f-48d1-bceb-0dffbd0dbeb5', NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', '9e0b1e34-f06d-435e-955e-94d32ae75d82', 1, 30, true, '25064501-129b-4ba6-8847-36bb4f5e9b88', NULL);
INSERT INTO public.authentication_execution VALUES ('3152cdf6-69bf-46d5-92a4-c5ebe94dc6d1', NULL, 'conditional-user-configured', 'da831425-93a2-4023-b385-9915e55fffcf', '25064501-129b-4ba6-8847-36bb4f5e9b88', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('9284bd33-1730-42bb-a71b-7b74857d3630', NULL, 'direct-grant-validate-otp', 'da831425-93a2-4023-b385-9915e55fffcf', '25064501-129b-4ba6-8847-36bb4f5e9b88', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('eb857086-31ec-4f33-ae56-27b85c004b70', NULL, 'registration-page-form', 'da831425-93a2-4023-b385-9915e55fffcf', '16b4d6ad-cfd3-4c65-811f-555277528a20', 0, 10, true, 'e19f8ca4-d1c7-4074-8321-c3f2bced700a', NULL);
INSERT INTO public.authentication_execution VALUES ('f07eb5d1-f2b2-4147-9e5d-9c7cd94b8884', NULL, 'registration-user-creation', 'da831425-93a2-4023-b385-9915e55fffcf', 'e19f8ca4-d1c7-4074-8321-c3f2bced700a', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('dbdd1b55-8ff0-4088-afe8-0f504328f91f', NULL, 'registration-password-action', 'da831425-93a2-4023-b385-9915e55fffcf', 'e19f8ca4-d1c7-4074-8321-c3f2bced700a', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('f599ea3d-22df-4271-b235-0fd2aff52173', NULL, 'registration-recaptcha-action', 'da831425-93a2-4023-b385-9915e55fffcf', 'e19f8ca4-d1c7-4074-8321-c3f2bced700a', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b44ba922-2c59-4d95-8248-47fdc94bac9f', NULL, 'registration-terms-and-conditions', 'da831425-93a2-4023-b385-9915e55fffcf', 'e19f8ca4-d1c7-4074-8321-c3f2bced700a', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('bb96ddef-4fac-40bd-8ebd-0250644e95a8', NULL, 'reset-credentials-choose-user', 'da831425-93a2-4023-b385-9915e55fffcf', '90ed8dc3-35f7-489c-acce-98f3c072dc1f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('45c24bbe-6b58-4267-96ef-08957f1448c9', NULL, 'reset-credential-email', 'da831425-93a2-4023-b385-9915e55fffcf', '90ed8dc3-35f7-489c-acce-98f3c072dc1f', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('07bc63c4-0633-40b9-8f8e-d49c07c2f5ad', NULL, 'reset-password', 'da831425-93a2-4023-b385-9915e55fffcf', '90ed8dc3-35f7-489c-acce-98f3c072dc1f', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c04a07bd-666e-4ae2-8853-1c67d3bac4f5', NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', '90ed8dc3-35f7-489c-acce-98f3c072dc1f', 1, 40, true, 'e936b2e0-672f-44f9-bc85-791c245318db', NULL);
INSERT INTO public.authentication_execution VALUES ('33ddfd7e-caf4-4825-b184-4156e6cf0a87', NULL, 'conditional-user-configured', 'da831425-93a2-4023-b385-9915e55fffcf', 'e936b2e0-672f-44f9-bc85-791c245318db', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d1a08f04-8251-4d04-8798-02cdacef2486', NULL, 'reset-otp', 'da831425-93a2-4023-b385-9915e55fffcf', 'e936b2e0-672f-44f9-bc85-791c245318db', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d46d45f5-0b06-4a24-8ebd-3111a0e398da', NULL, 'client-secret', 'da831425-93a2-4023-b385-9915e55fffcf', '157d738b-1846-44f0-b92e-47eecd87a79e', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('47c32ad8-b272-44d7-b6d8-e5c0794391c2', NULL, 'client-jwt', 'da831425-93a2-4023-b385-9915e55fffcf', '157d738b-1846-44f0-b92e-47eecd87a79e', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('6faa32bb-329a-4962-894c-b7149748c2e9', NULL, 'client-secret-jwt', 'da831425-93a2-4023-b385-9915e55fffcf', '157d738b-1846-44f0-b92e-47eecd87a79e', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('688b4397-1845-4266-9a02-de8e03d62199', NULL, 'client-x509', 'da831425-93a2-4023-b385-9915e55fffcf', '157d738b-1846-44f0-b92e-47eecd87a79e', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('7e240d9b-d225-4168-87fe-057be2dc8e1a', NULL, 'idp-review-profile', 'da831425-93a2-4023-b385-9915e55fffcf', 'b9905de3-dfa5-4bca-a4e9-ce3400eb9d0d', 0, 10, false, NULL, '1b1fe670-3357-41c4-9f31-76750cc1eb9c');
INSERT INTO public.authentication_execution VALUES ('c7bb03d9-7ea3-45b6-97c7-9139c93693ce', NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', 'b9905de3-dfa5-4bca-a4e9-ce3400eb9d0d', 0, 20, true, '5af4a53d-fcca-445c-9ca1-4eec7a5682ee', NULL);
INSERT INTO public.authentication_execution VALUES ('35d4614d-f513-4523-ac1f-723232b37101', NULL, 'idp-create-user-if-unique', 'da831425-93a2-4023-b385-9915e55fffcf', '5af4a53d-fcca-445c-9ca1-4eec7a5682ee', 2, 10, false, NULL, '82f66ed6-bec8-4fcf-9776-5c9507c12c1e');
INSERT INTO public.authentication_execution VALUES ('76172033-e9e2-47ee-9b6e-da05015cbd17', NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', '5af4a53d-fcca-445c-9ca1-4eec7a5682ee', 2, 20, true, '03289686-ba08-4e46-90b4-7bdbf75549d3', NULL);
INSERT INTO public.authentication_execution VALUES ('e872e113-f2ae-4611-bdc5-2f2ae2abaf93', NULL, 'idp-confirm-link', 'da831425-93a2-4023-b385-9915e55fffcf', '03289686-ba08-4e46-90b4-7bdbf75549d3', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b3ba0550-709b-4979-b277-de9f74dd19d3', NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', '03289686-ba08-4e46-90b4-7bdbf75549d3', 0, 20, true, 'cee892b9-51ef-4c55-8591-776a0eb6189f', NULL);
INSERT INTO public.authentication_execution VALUES ('9548711e-e2b5-4827-a6a0-13dde9e955fa', NULL, 'idp-email-verification', 'da831425-93a2-4023-b385-9915e55fffcf', 'cee892b9-51ef-4c55-8591-776a0eb6189f', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('af889f49-5462-4896-98b6-809934bb637c', NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', 'cee892b9-51ef-4c55-8591-776a0eb6189f', 2, 20, true, '6af0957b-4112-4669-8ac7-954b7d7a5415', NULL);
INSERT INTO public.authentication_execution VALUES ('53c568ed-15e4-43ab-9737-f0f4b6add585', NULL, 'idp-username-password-form', 'da831425-93a2-4023-b385-9915e55fffcf', '6af0957b-4112-4669-8ac7-954b7d7a5415', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('32ad24ef-e2d0-40d1-9572-d293ec083284', NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', '6af0957b-4112-4669-8ac7-954b7d7a5415', 1, 20, true, 'eef69dab-00f3-4f03-85a6-9d1d4786983d', NULL);
INSERT INTO public.authentication_execution VALUES ('d2ed6909-b928-4b0c-accb-7b624a1c1b4c', NULL, 'conditional-user-configured', 'da831425-93a2-4023-b385-9915e55fffcf', 'eef69dab-00f3-4f03-85a6-9d1d4786983d', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('bd1cc983-0628-4878-bb7d-ad1f5cfcd339', NULL, 'auth-otp-form', 'da831425-93a2-4023-b385-9915e55fffcf', 'eef69dab-00f3-4f03-85a6-9d1d4786983d', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('124e526d-3478-4646-84d9-27aa18dee61e', NULL, 'webauthn-authenticator', 'da831425-93a2-4023-b385-9915e55fffcf', 'eef69dab-00f3-4f03-85a6-9d1d4786983d', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5a90eb3c-a15b-4c1c-ac87-33a0b752ab29', NULL, 'auth-recovery-authn-code-form', 'da831425-93a2-4023-b385-9915e55fffcf', 'eef69dab-00f3-4f03-85a6-9d1d4786983d', 3, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d1c49cbc-aa16-4bab-a12f-a75aa3554147', NULL, 'http-basic-authenticator', 'da831425-93a2-4023-b385-9915e55fffcf', 'df593992-725f-401b-9501-7b56c034b2b6', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('37cb59fc-bc30-4e7b-ae69-10efa6293619', NULL, 'docker-http-basic-authenticator', 'da831425-93a2-4023-b385-9915e55fffcf', '57f2b248-158a-47a1-9e75-c880516fc8b6', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('997dcfb5-416b-4423-b164-754d08102952', NULL, 'auth-cookie', '0eb506ab-27da-48e4-8527-269495758e81', 'f6e239d5-c24e-49f2-831d-a3ed2dbc34b8', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('905cb557-c85a-4f58-8847-aa85843fcb78', NULL, 'auth-spnego', '0eb506ab-27da-48e4-8527-269495758e81', 'f6e239d5-c24e-49f2-831d-a3ed2dbc34b8', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0d795a57-48f2-4b39-9377-bc74748572fd', NULL, 'identity-provider-redirector', '0eb506ab-27da-48e4-8527-269495758e81', 'f6e239d5-c24e-49f2-831d-a3ed2dbc34b8', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('73022f2c-4f93-4dc1-87c1-3d725078b956', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', 'f6e239d5-c24e-49f2-831d-a3ed2dbc34b8', 2, 30, true, '5cf75dce-b63d-4b26-9611-c993f93fa7b2', NULL);
INSERT INTO public.authentication_execution VALUES ('b8ff3ffe-0190-4d33-869b-bef1fb16fd2b', NULL, 'auth-username-password-form', '0eb506ab-27da-48e4-8527-269495758e81', '5cf75dce-b63d-4b26-9611-c993f93fa7b2', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('bb7e9861-72e3-428d-b137-13b0c8e8d359', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', '5cf75dce-b63d-4b26-9611-c993f93fa7b2', 1, 20, true, '535b362c-e730-42a3-b982-46a30082640f', NULL);
INSERT INTO public.authentication_execution VALUES ('3b0e5220-d3fd-4097-b424-4263acddbbc7', NULL, 'conditional-user-configured', '0eb506ab-27da-48e4-8527-269495758e81', '535b362c-e730-42a3-b982-46a30082640f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('2fbc5c1f-58a7-4270-8d80-5bbb2b7e5fce', NULL, 'auth-otp-form', '0eb506ab-27da-48e4-8527-269495758e81', '535b362c-e730-42a3-b982-46a30082640f', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('11462959-05ca-4b07-8e7e-940a0e48f6e7', NULL, 'webauthn-authenticator', '0eb506ab-27da-48e4-8527-269495758e81', '535b362c-e730-42a3-b982-46a30082640f', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('367c3718-460c-4704-87ae-6579ac9f8914', NULL, 'auth-recovery-authn-code-form', '0eb506ab-27da-48e4-8527-269495758e81', '535b362c-e730-42a3-b982-46a30082640f', 3, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('08f6bea0-fd0c-44a2-aed0-3c10722a9809', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', 'f6e239d5-c24e-49f2-831d-a3ed2dbc34b8', 2, 26, true, '7b078d7e-fefc-4ddf-a95c-0d49b9e56998', NULL);
INSERT INTO public.authentication_execution VALUES ('54925f02-1412-450c-9c9b-70a85faf8796', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', '7b078d7e-fefc-4ddf-a95c-0d49b9e56998', 1, 10, true, 'd91b3bdb-bde0-4ef2-831f-95530ce4b706', NULL);
INSERT INTO public.authentication_execution VALUES ('adb62a67-0179-4e05-b4a5-24e30ff44bd5', NULL, 'conditional-user-configured', '0eb506ab-27da-48e4-8527-269495758e81', 'd91b3bdb-bde0-4ef2-831f-95530ce4b706', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('321df390-7fed-4743-9bed-fdc01733ede3', NULL, 'organization', '0eb506ab-27da-48e4-8527-269495758e81', 'd91b3bdb-bde0-4ef2-831f-95530ce4b706', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ff6ecc0c-7447-4c8c-8a21-bfb70c9c1b36', NULL, 'direct-grant-validate-username', '0eb506ab-27da-48e4-8527-269495758e81', 'dd3e5bad-a499-4d81-8c8f-23d1ba8db4c7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0ba5efd4-e5b3-441f-a597-3085cedfda7e', NULL, 'direct-grant-validate-password', '0eb506ab-27da-48e4-8527-269495758e81', 'dd3e5bad-a499-4d81-8c8f-23d1ba8db4c7', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('aae78d7e-f033-41a6-9ec2-cf5c0b383a8a', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', 'dd3e5bad-a499-4d81-8c8f-23d1ba8db4c7', 1, 30, true, '819c1470-099e-404c-995e-e3f385159c98', NULL);
INSERT INTO public.authentication_execution VALUES ('faafbc31-f85c-41b1-9ba9-6ccb7d2de24d', NULL, 'conditional-user-configured', '0eb506ab-27da-48e4-8527-269495758e81', '819c1470-099e-404c-995e-e3f385159c98', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('7b6fd3a5-02a0-4926-997a-2e0a71035880', NULL, 'direct-grant-validate-otp', '0eb506ab-27da-48e4-8527-269495758e81', '819c1470-099e-404c-995e-e3f385159c98', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5a276486-9935-4417-9f70-12ed599a33cd', NULL, 'registration-page-form', '0eb506ab-27da-48e4-8527-269495758e81', '87b5028c-9c62-460d-baad-38318dd9811f', 0, 10, true, 'f42e7d17-0682-48f3-853b-b0a9233634e6', NULL);
INSERT INTO public.authentication_execution VALUES ('c38bd559-49da-477c-9422-88503252752b', NULL, 'registration-user-creation', '0eb506ab-27da-48e4-8527-269495758e81', 'f42e7d17-0682-48f3-853b-b0a9233634e6', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('98b3887d-b9fe-4414-9b57-b413459ccbd0', NULL, 'registration-password-action', '0eb506ab-27da-48e4-8527-269495758e81', 'f42e7d17-0682-48f3-853b-b0a9233634e6', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('335d25e9-e332-4a06-b80b-81b0d72ece2e', NULL, 'registration-recaptcha-action', '0eb506ab-27da-48e4-8527-269495758e81', 'f42e7d17-0682-48f3-853b-b0a9233634e6', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('fb236ec2-0719-4e2c-b60b-cf548ceead01', NULL, 'registration-terms-and-conditions', '0eb506ab-27da-48e4-8527-269495758e81', 'f42e7d17-0682-48f3-853b-b0a9233634e6', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('799d4900-2efc-43f2-9dc5-b11d74f5b306', NULL, 'reset-credentials-choose-user', '0eb506ab-27da-48e4-8527-269495758e81', '1613b3fd-59e4-4a06-ae37-c1c5b685c5e9', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('2eef8774-a36e-484b-b7b4-b6ae790c3cf3', NULL, 'reset-credential-email', '0eb506ab-27da-48e4-8527-269495758e81', '1613b3fd-59e4-4a06-ae37-c1c5b685c5e9', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5673c14d-21a7-4319-b19a-b00bad540585', NULL, 'reset-password', '0eb506ab-27da-48e4-8527-269495758e81', '1613b3fd-59e4-4a06-ae37-c1c5b685c5e9', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1f139b0f-7e15-4fe5-9731-7aaf0b6bfe59', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', '1613b3fd-59e4-4a06-ae37-c1c5b685c5e9', 1, 40, true, '3710437c-727b-44ed-9fd8-4da2aeaf9290', NULL);
INSERT INTO public.authentication_execution VALUES ('4618f229-30f4-43b0-9374-ce396c5a3704', NULL, 'conditional-user-configured', '0eb506ab-27da-48e4-8527-269495758e81', '3710437c-727b-44ed-9fd8-4da2aeaf9290', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('acb03a52-71af-4978-b0aa-3978c62e32aa', NULL, 'reset-otp', '0eb506ab-27da-48e4-8527-269495758e81', '3710437c-727b-44ed-9fd8-4da2aeaf9290', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('c420fba9-0ddc-4085-9d5d-8d97426b1f16', NULL, 'client-secret', '0eb506ab-27da-48e4-8527-269495758e81', 'bc761cc0-46b2-4c13-a7ca-e66abbb79891', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a35700d7-cd35-4984-afe8-a3db99f171b7', NULL, 'client-jwt', '0eb506ab-27da-48e4-8527-269495758e81', 'bc761cc0-46b2-4c13-a7ca-e66abbb79891', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5b168ae1-6b45-43ed-8439-73e3ce41158c', NULL, 'client-secret-jwt', '0eb506ab-27da-48e4-8527-269495758e81', 'bc761cc0-46b2-4c13-a7ca-e66abbb79891', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('5e6f7b7b-7159-4edb-a6c6-1da8d56d27f5', NULL, 'client-x509', '0eb506ab-27da-48e4-8527-269495758e81', 'bc761cc0-46b2-4c13-a7ca-e66abbb79891', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('0b5b113e-8acf-4d43-8967-476fa0306dcd', NULL, 'idp-review-profile', '0eb506ab-27da-48e4-8527-269495758e81', '5966fa83-980b-4c7d-bf33-5491ebcdf9c9', 0, 10, false, NULL, 'f6ad36c4-6518-4d7e-b0fe-98da25ac4cda');
INSERT INTO public.authentication_execution VALUES ('4eaf6d55-9f24-4518-8a58-aa434a5faa4b', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', '5966fa83-980b-4c7d-bf33-5491ebcdf9c9', 0, 20, true, 'dde5329e-830b-4518-9252-1fc4d6c4cbb6', NULL);
INSERT INTO public.authentication_execution VALUES ('dd9ac39b-79f6-4c9e-b43f-eeb05841b236', NULL, 'idp-create-user-if-unique', '0eb506ab-27da-48e4-8527-269495758e81', 'dde5329e-830b-4518-9252-1fc4d6c4cbb6', 2, 10, false, NULL, '055364b8-1919-43c0-ad5e-ed09c9130eac');
INSERT INTO public.authentication_execution VALUES ('44cd9970-e609-4693-89ca-e5c92979e177', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', 'dde5329e-830b-4518-9252-1fc4d6c4cbb6', 2, 20, true, '5fe24dec-698f-48b9-9d43-7cea748280a1', NULL);
INSERT INTO public.authentication_execution VALUES ('67f42f8d-de55-48e6-bcbd-a5225a9de475', NULL, 'idp-confirm-link', '0eb506ab-27da-48e4-8527-269495758e81', '5fe24dec-698f-48b9-9d43-7cea748280a1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('ee1c2365-a07f-4dfa-8e56-52ea9e7fb431', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', '5fe24dec-698f-48b9-9d43-7cea748280a1', 0, 20, true, 'a460ce7a-5abe-411a-9c20-abaaf09e8004', NULL);
INSERT INTO public.authentication_execution VALUES ('e9363d93-cb3a-4019-8726-c3be4e77d79a', NULL, 'idp-email-verification', '0eb506ab-27da-48e4-8527-269495758e81', 'a460ce7a-5abe-411a-9c20-abaaf09e8004', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('1cd78eb4-e835-4ef5-8749-aec2cb31068e', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', 'a460ce7a-5abe-411a-9c20-abaaf09e8004', 2, 20, true, 'e86d3649-5501-48a3-b49c-941d7c8c44a7', NULL);
INSERT INTO public.authentication_execution VALUES ('dfdf60da-07a1-425a-af83-bbbb6daf4d98', NULL, 'idp-username-password-form', '0eb506ab-27da-48e4-8527-269495758e81', 'e86d3649-5501-48a3-b49c-941d7c8c44a7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('a2197ca7-fa5c-47ae-95b7-a0f1d650f955', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', 'e86d3649-5501-48a3-b49c-941d7c8c44a7', 1, 20, true, 'd05df2df-29b9-4ce7-9ada-05b3e50a8232', NULL);
INSERT INTO public.authentication_execution VALUES ('431519f9-685d-4c47-983d-4febefd98884', NULL, 'conditional-user-configured', '0eb506ab-27da-48e4-8527-269495758e81', 'd05df2df-29b9-4ce7-9ada-05b3e50a8232', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('b1be3c95-9229-4c09-8244-d98d5ba07fb6', NULL, 'auth-otp-form', '0eb506ab-27da-48e4-8527-269495758e81', 'd05df2df-29b9-4ce7-9ada-05b3e50a8232', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('adf1d634-661e-47f9-99a2-f9f0a673b8a2', NULL, 'webauthn-authenticator', '0eb506ab-27da-48e4-8527-269495758e81', 'd05df2df-29b9-4ce7-9ada-05b3e50a8232', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e085de0e-3902-4971-b2f7-e32ca9fc0d55', NULL, 'auth-recovery-authn-code-form', '0eb506ab-27da-48e4-8527-269495758e81', 'd05df2df-29b9-4ce7-9ada-05b3e50a8232', 3, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('d81511be-b1f4-4798-89b2-35a0b36bcdd7', NULL, NULL, '0eb506ab-27da-48e4-8527-269495758e81', '5966fa83-980b-4c7d-bf33-5491ebcdf9c9', 1, 50, true, '9b5a37ca-a7d3-4328-832e-18a548d7c725', NULL);
INSERT INTO public.authentication_execution VALUES ('fa774dc1-4ea0-4857-a2ad-6625d2eee45d', NULL, 'conditional-user-configured', '0eb506ab-27da-48e4-8527-269495758e81', '9b5a37ca-a7d3-4328-832e-18a548d7c725', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('33a33f41-4c07-4899-830a-a9426c433a15', NULL, 'idp-add-organization-member', '0eb506ab-27da-48e4-8527-269495758e81', '9b5a37ca-a7d3-4328-832e-18a548d7c725', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('e1291017-14e9-4e75-8f4c-71e89d234229', NULL, 'http-basic-authenticator', '0eb506ab-27da-48e4-8527-269495758e81', 'e69aff4d-6de3-4e88-81c0-926f53fd5de9', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution VALUES ('08a09552-900a-4cc3-a1db-f61fad0975eb', NULL, 'docker-http-basic-authenticator', '0eb506ab-27da-48e4-8527-269495758e81', '5dc762c0-c343-4503-b57c-bd2bc02b4064', 0, 10, false, NULL, NULL);


--
-- TOC entry 4224 (class 0 OID 17027)
-- Dependencies: 245
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authentication_flow VALUES ('4637261a-0c87-427e-9bd2-99dd6fbcccc6', 'browser', 'Browser based authentication', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('237effd1-207d-4355-a77a-ff3f37118718', 'forms', 'Username, password, otp and other auth forms.', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('3d73ccfa-eca3-48b1-bab1-2c4a8e7dcd15', 'Browser - Conditional 2FA', 'Flow to determine if any 2FA is required for the authentication', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('9e0b1e34-f06d-435e-955e-94d32ae75d82', 'direct grant', 'OpenID Connect Resource Owner Grant', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('25064501-129b-4ba6-8847-36bb4f5e9b88', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('16b4d6ad-cfd3-4c65-811f-555277528a20', 'registration', 'Registration flow', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('e19f8ca4-d1c7-4074-8321-c3f2bced700a', 'registration form', 'Registration form', 'da831425-93a2-4023-b385-9915e55fffcf', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('90ed8dc3-35f7-489c-acce-98f3c072dc1f', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('e936b2e0-672f-44f9-bc85-791c245318db', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('157d738b-1846-44f0-b92e-47eecd87a79e', 'clients', 'Base authentication for clients', 'da831425-93a2-4023-b385-9915e55fffcf', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('b9905de3-dfa5-4bca-a4e9-ce3400eb9d0d', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('5af4a53d-fcca-445c-9ca1-4eec7a5682ee', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('03289686-ba08-4e46-90b4-7bdbf75549d3', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('cee892b9-51ef-4c55-8591-776a0eb6189f', 'Account verification options', 'Method with which to verity the existing account', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('6af0957b-4112-4669-8ac7-954b7d7a5415', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('eef69dab-00f3-4f03-85a6-9d1d4786983d', 'First broker login - Conditional 2FA', 'Flow to determine if any 2FA is required for the authentication', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('df593992-725f-401b-9501-7b56c034b2b6', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('57f2b248-158a-47a1-9e75-c880516fc8b6', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'da831425-93a2-4023-b385-9915e55fffcf', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('f6e239d5-c24e-49f2-831d-a3ed2dbc34b8', 'browser', 'Browser based authentication', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('5cf75dce-b63d-4b26-9611-c993f93fa7b2', 'forms', 'Username, password, otp and other auth forms.', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('535b362c-e730-42a3-b982-46a30082640f', 'Browser - Conditional 2FA', 'Flow to determine if any 2FA is required for the authentication', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('7b078d7e-fefc-4ddf-a95c-0d49b9e56998', 'Organization', NULL, '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('d91b3bdb-bde0-4ef2-831f-95530ce4b706', 'Browser - Conditional Organization', 'Flow to determine if the organization identity-first login is to be used', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('dd3e5bad-a499-4d81-8c8f-23d1ba8db4c7', 'direct grant', 'OpenID Connect Resource Owner Grant', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('819c1470-099e-404c-995e-e3f385159c98', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('87b5028c-9c62-460d-baad-38318dd9811f', 'registration', 'Registration flow', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('f42e7d17-0682-48f3-853b-b0a9233634e6', 'registration form', 'Registration form', '0eb506ab-27da-48e4-8527-269495758e81', 'form-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('1613b3fd-59e4-4a06-ae37-c1c5b685c5e9', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('3710437c-727b-44ed-9fd8-4da2aeaf9290', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('bc761cc0-46b2-4c13-a7ca-e66abbb79891', 'clients', 'Base authentication for clients', '0eb506ab-27da-48e4-8527-269495758e81', 'client-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('5966fa83-980b-4c7d-bf33-5491ebcdf9c9', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('dde5329e-830b-4518-9252-1fc4d6c4cbb6', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('5fe24dec-698f-48b9-9d43-7cea748280a1', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('a460ce7a-5abe-411a-9c20-abaaf09e8004', 'Account verification options', 'Method with which to verity the existing account', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('e86d3649-5501-48a3-b49c-941d7c8c44a7', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('d05df2df-29b9-4ce7-9ada-05b3e50a8232', 'First broker login - Conditional 2FA', 'Flow to determine if any 2FA is required for the authentication', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('9b5a37ca-a7d3-4328-832e-18a548d7c725', 'First Broker Login - Conditional Organization', 'Flow to determine if the authenticator that adds organization members is to be used', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', false, true);
INSERT INTO public.authentication_flow VALUES ('e69aff4d-6de3-4e88-81c0-926f53fd5de9', 'saml ecp', 'SAML ECP Profile Authentication Flow', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', true, true);
INSERT INTO public.authentication_flow VALUES ('5dc762c0-c343-4503-b57c-bd2bc02b4064', 'docker auth', 'Used by Docker clients to authenticate against the IDP', '0eb506ab-27da-48e4-8527-269495758e81', 'basic-flow', true, true);


--
-- TOC entry 4223 (class 0 OID 17022)
-- Dependencies: 244
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authenticator_config VALUES ('1b1fe670-3357-41c4-9f31-76750cc1eb9c', 'review profile config', 'da831425-93a2-4023-b385-9915e55fffcf');
INSERT INTO public.authenticator_config VALUES ('82f66ed6-bec8-4fcf-9776-5c9507c12c1e', 'create unique user config', 'da831425-93a2-4023-b385-9915e55fffcf');
INSERT INTO public.authenticator_config VALUES ('f6ad36c4-6518-4d7e-b0fe-98da25ac4cda', 'review profile config', '0eb506ab-27da-48e4-8527-269495758e81');
INSERT INTO public.authenticator_config VALUES ('055364b8-1919-43c0-ad5e-ed09c9130eac', 'create unique user config', '0eb506ab-27da-48e4-8527-269495758e81');


--
-- TOC entry 4226 (class 0 OID 17037)
-- Dependencies: 247
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authenticator_config_entry VALUES ('1b1fe670-3357-41c4-9f31-76750cc1eb9c', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry VALUES ('82f66ed6-bec8-4fcf-9776-5c9507c12c1e', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry VALUES ('055364b8-1919-43c0-ad5e-ed09c9130eac', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry VALUES ('f6ad36c4-6518-4d7e-b0fe-98da25ac4cda', 'missing', 'update.profile.on.first.login');


--
-- TOC entry 4250 (class 0 OID 17475)
-- Dependencies: 271
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4190 (class 0 OID 16398)
-- Dependencies: 211
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, 'da831425-93a2-4023-b385-9915e55fffcf', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'da831425-93a2-4023-b385-9915e55fffcf', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'da831425-93a2-4023-b385-9915e55fffcf', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'da831425-93a2-4023-b385-9915e55fffcf', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', true, true, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, 'da831425-93a2-4023-b385-9915e55fffcf', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', true, true, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'da831425-93a2-4023-b385-9915e55fffcf', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', true, true, 'security-admin-console', 0, true, NULL, '/admin/redirect-login-example/console/', false, NULL, false, '0eb506ab-27da-48e4-8527-269495758e81', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', true, true, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, '0eb506ab-27da-48e4-8527-269495758e81', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client VALUES ('da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, false, 'redirect-login-example-realm', 0, false, NULL, NULL, true, NULL, false, 'da831425-93a2-4023-b385-9915e55fffcf', NULL, 0, false, false, 'redirect-login-example Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, false, 'realm-management', 0, false, NULL, NULL, true, NULL, false, '0eb506ab-27da-48e4-8527-269495758e81', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', true, false, 'account', 0, true, NULL, '/realms/redirect-login-example/account/', false, NULL, false, '0eb506ab-27da-48e4-8527-269495758e81', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', true, false, 'account-console', 0, true, NULL, '/realms/redirect-login-example/account/', false, NULL, false, '0eb506ab-27da-48e4-8527-269495758e81', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, '0eb506ab-27da-48e4-8527-269495758e81', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', true, true, 'oidc-client', 0, false, 'pvRQkTKcE2zZw9vxT30oXC1Zynq2b3yw', 'http://localhost:8083', false, '', false, '0eb506ab-27da-48e4-8527-269495758e81', 'openid-connect', -1, true, false, 'OIDC Client', false, 'client-secret', '', 'Client configured to redirect to the login screen if the user is not authenticated', NULL, true, false, true, false);


--
-- TOC entry 4209 (class 0 OID 16756)
-- Dependencies: 230
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_attributes VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('61790db7-d140-473c-ba70-cd70494f4460', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO public.client_attributes VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'client.secret.creation.time', '1754246587');
INSERT INTO public.client_attributes VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'standard.token.exchange.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'oauth2.device.authorization.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'oidc.ciba.grant.enabled', 'false');
INSERT INTO public.client_attributes VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'backchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'backchannel.logout.revoke.offline.tokens', 'false');
INSERT INTO public.client_attributes VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'realm_client', 'false');
INSERT INTO public.client_attributes VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'display.on.consent.screen', 'false');
INSERT INTO public.client_attributes VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'frontchannel.logout.session.required', 'true');


--
-- TOC entry 4261 (class 0 OID 17724)
-- Dependencies: 282
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4260 (class 0 OID 17599)
-- Dependencies: 281
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4210 (class 0 OID 16766)
-- Dependencies: 231
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4238 (class 0 OID 17265)
-- Dependencies: 259
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope VALUES ('030c326e-b624-4f7f-8735-779e4ef5733c', 'offline_access', 'da831425-93a2-4023-b385-9915e55fffcf', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('061110cc-5726-47c8-9803-dd277e4aabec', 'role_list', 'da831425-93a2-4023-b385-9915e55fffcf', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('eccb4615-bb99-4b28-8af8-1016382093d4', 'saml_organization', 'da831425-93a2-4023-b385-9915e55fffcf', 'Organization Membership', 'saml');
INSERT INTO public.client_scope VALUES ('c6308cac-c900-472e-a60f-76336a232dfd', 'profile', 'da831425-93a2-4023-b385-9915e55fffcf', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('636624a3-b62d-416d-8db1-61554f390979', 'email', 'da831425-93a2-4023-b385-9915e55fffcf', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('d5097cb9-e315-48cb-ae0d-c3f825216ae1', 'address', 'da831425-93a2-4023-b385-9915e55fffcf', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', 'phone', 'da831425-93a2-4023-b385-9915e55fffcf', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('ec75baec-3f28-4316-a77b-270b14aaebcb', 'roles', 'da831425-93a2-4023-b385-9915e55fffcf', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('e97bffb3-edcd-4cce-a59f-32226a722aa8', 'web-origins', 'da831425-93a2-4023-b385-9915e55fffcf', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('4aaf5956-dbfa-448f-a54b-b013cea9449a', 'microprofile-jwt', 'da831425-93a2-4023-b385-9915e55fffcf', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope VALUES ('04514393-724d-4c68-a20a-322ba0e46344', 'acr', 'da831425-93a2-4023-b385-9915e55fffcf', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('922c2c89-57b2-49a4-abff-11db6e2fb952', 'basic', 'da831425-93a2-4023-b385-9915e55fffcf', 'OpenID Connect scope for add all basic claims to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('c848eb88-1758-4cfc-95a9-976c68304fb7', 'service_account', 'da831425-93a2-4023-b385-9915e55fffcf', 'Specific scope for a client enabled for service accounts', 'openid-connect');
INSERT INTO public.client_scope VALUES ('2bf591c3-1a81-45c1-a79f-3a15d908ab43', 'organization', 'da831425-93a2-4023-b385-9915e55fffcf', 'Additional claims about the organization a subject belongs to', 'openid-connect');
INSERT INTO public.client_scope VALUES ('3196be8c-060c-48f3-acf7-e2114a5d0f17', 'offline_access', '0eb506ab-27da-48e4-8527-269495758e81', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope VALUES ('704448ae-f988-4169-b13e-ab93ac0ea3f8', 'role_list', '0eb506ab-27da-48e4-8527-269495758e81', 'SAML role list', 'saml');
INSERT INTO public.client_scope VALUES ('b6049d9d-efe2-4124-86dc-e87cf6ba4be8', 'saml_organization', '0eb506ab-27da-48e4-8527-269495758e81', 'Organization Membership', 'saml');
INSERT INTO public.client_scope VALUES ('334b3943-1d2f-437b-804e-17e81664d2d6', 'profile', '0eb506ab-27da-48e4-8527-269495758e81', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope VALUES ('ffc79c04-2f92-497b-98e1-5d10e72e0a8f', 'email', '0eb506ab-27da-48e4-8527-269495758e81', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope VALUES ('ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', 'address', '0eb506ab-27da-48e4-8527-269495758e81', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope VALUES ('51d9887b-6ccb-4474-bd51-7ee28b53dfef', 'phone', '0eb506ab-27da-48e4-8527-269495758e81', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope VALUES ('87b55b00-2895-4c6f-b55e-d724a97f3c2e', 'roles', '0eb506ab-27da-48e4-8527-269495758e81', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('768a4ef6-c078-448b-a7bf-8eab89b0d4d6', 'web-origins', '0eb506ab-27da-48e4-8527-269495758e81', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', 'microprofile-jwt', '0eb506ab-27da-48e4-8527-269495758e81', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope VALUES ('6b9e8638-69ce-4b28-99e2-7d87f5f78da6', 'acr', '0eb506ab-27da-48e4-8527-269495758e81', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', 'basic', '0eb506ab-27da-48e4-8527-269495758e81', 'OpenID Connect scope for add all basic claims to the token', 'openid-connect');
INSERT INTO public.client_scope VALUES ('3a710695-c13d-423d-8163-01f505c8a89e', 'service_account', '0eb506ab-27da-48e4-8527-269495758e81', 'Specific scope for a client enabled for service accounts', 'openid-connect');
INSERT INTO public.client_scope VALUES ('a6926d37-9345-4ced-baa7-de2a208f9e50', 'organization', '0eb506ab-27da-48e4-8527-269495758e81', 'Additional claims about the organization a subject belongs to', 'openid-connect');


--
-- TOC entry 4239 (class 0 OID 17279)
-- Dependencies: 260
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_attributes VALUES ('030c326e-b624-4f7f-8735-779e4ef5733c', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('030c326e-b624-4f7f-8735-779e4ef5733c', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('061110cc-5726-47c8-9803-dd277e4aabec', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('061110cc-5726-47c8-9803-dd277e4aabec', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('eccb4615-bb99-4b28-8af8-1016382093d4', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('c6308cac-c900-472e-a60f-76336a232dfd', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('c6308cac-c900-472e-a60f-76336a232dfd', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('c6308cac-c900-472e-a60f-76336a232dfd', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('636624a3-b62d-416d-8db1-61554f390979', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('636624a3-b62d-416d-8db1-61554f390979', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('636624a3-b62d-416d-8db1-61554f390979', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('d5097cb9-e315-48cb-ae0d-c3f825216ae1', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('d5097cb9-e315-48cb-ae0d-c3f825216ae1', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('d5097cb9-e315-48cb-ae0d-c3f825216ae1', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('ec75baec-3f28-4316-a77b-270b14aaebcb', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('ec75baec-3f28-4316-a77b-270b14aaebcb', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('ec75baec-3f28-4316-a77b-270b14aaebcb', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('e97bffb3-edcd-4cce-a59f-32226a722aa8', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('e97bffb3-edcd-4cce-a59f-32226a722aa8', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('e97bffb3-edcd-4cce-a59f-32226a722aa8', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('4aaf5956-dbfa-448f-a54b-b013cea9449a', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('4aaf5956-dbfa-448f-a54b-b013cea9449a', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('04514393-724d-4c68-a20a-322ba0e46344', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('04514393-724d-4c68-a20a-322ba0e46344', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('922c2c89-57b2-49a4-abff-11db6e2fb952', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('922c2c89-57b2-49a4-abff-11db6e2fb952', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('c848eb88-1758-4cfc-95a9-976c68304fb7', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('c848eb88-1758-4cfc-95a9-976c68304fb7', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('2bf591c3-1a81-45c1-a79f-3a15d908ab43', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('2bf591c3-1a81-45c1-a79f-3a15d908ab43', '${organizationScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('2bf591c3-1a81-45c1-a79f-3a15d908ab43', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('3196be8c-060c-48f3-acf7-e2114a5d0f17', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('3196be8c-060c-48f3-acf7-e2114a5d0f17', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('704448ae-f988-4169-b13e-ab93ac0ea3f8', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('704448ae-f988-4169-b13e-ab93ac0ea3f8', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('b6049d9d-efe2-4124-86dc-e87cf6ba4be8', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('334b3943-1d2f-437b-804e-17e81664d2d6', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('334b3943-1d2f-437b-804e-17e81664d2d6', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('334b3943-1d2f-437b-804e-17e81664d2d6', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('ffc79c04-2f92-497b-98e1-5d10e72e0a8f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('ffc79c04-2f92-497b-98e1-5d10e72e0a8f', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('ffc79c04-2f92-497b-98e1-5d10e72e0a8f', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('51d9887b-6ccb-4474-bd51-7ee28b53dfef', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('51d9887b-6ccb-4474-bd51-7ee28b53dfef', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('51d9887b-6ccb-4474-bd51-7ee28b53dfef', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('87b55b00-2895-4c6f-b55e-d724a97f3c2e', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('87b55b00-2895-4c6f-b55e-d724a97f3c2e', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('87b55b00-2895-4c6f-b55e-d724a97f3c2e', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('768a4ef6-c078-448b-a7bf-8eab89b0d4d6', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('768a4ef6-c078-448b-a7bf-8eab89b0d4d6', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('768a4ef6-c078-448b-a7bf-8eab89b0d4d6', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('6b9e8638-69ce-4b28-99e2-7d87f5f78da6', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('6b9e8638-69ce-4b28-99e2-7d87f5f78da6', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('3a710695-c13d-423d-8163-01f505c8a89e', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('3a710695-c13d-423d-8163-01f505c8a89e', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes VALUES ('a6926d37-9345-4ced-baa7-de2a208f9e50', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes VALUES ('a6926d37-9345-4ced-baa7-de2a208f9e50', '${organizationScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes VALUES ('a6926d37-9345-4ced-baa7-de2a208f9e50', 'true', 'include.in.token.scope');


--
-- TOC entry 4262 (class 0 OID 17765)
-- Dependencies: 283
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', 'ec75baec-3f28-4316-a77b-270b14aaebcb', true);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', '922c2c89-57b2-49a4-abff-11db6e2fb952', true);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', 'e97bffb3-edcd-4cce-a59f-32226a722aa8', true);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', '636624a3-b62d-416d-8db1-61554f390979', true);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', '04514393-724d-4c68-a20a-322ba0e46344', true);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', 'c6308cac-c900-472e-a60f-76336a232dfd', true);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', '8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', false);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', 'd5097cb9-e315-48cb-ae0d-c3f825216ae1', false);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', '030c326e-b624-4f7f-8735-779e4ef5733c', false);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', '2bf591c3-1a81-45c1-a79f-3a15d908ab43', false);
INSERT INTO public.client_scope_client VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', '4aaf5956-dbfa-448f-a54b-b013cea9449a', false);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', 'ec75baec-3f28-4316-a77b-270b14aaebcb', true);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', '922c2c89-57b2-49a4-abff-11db6e2fb952', true);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', 'e97bffb3-edcd-4cce-a59f-32226a722aa8', true);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', '636624a3-b62d-416d-8db1-61554f390979', true);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', '04514393-724d-4c68-a20a-322ba0e46344', true);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', 'c6308cac-c900-472e-a60f-76336a232dfd', true);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', '8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', false);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', 'd5097cb9-e315-48cb-ae0d-c3f825216ae1', false);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', '030c326e-b624-4f7f-8735-779e4ef5733c', false);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', '2bf591c3-1a81-45c1-a79f-3a15d908ab43', false);
INSERT INTO public.client_scope_client VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', '4aaf5956-dbfa-448f-a54b-b013cea9449a', false);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', 'ec75baec-3f28-4316-a77b-270b14aaebcb', true);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', '922c2c89-57b2-49a4-abff-11db6e2fb952', true);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', 'e97bffb3-edcd-4cce-a59f-32226a722aa8', true);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', '636624a3-b62d-416d-8db1-61554f390979', true);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', '04514393-724d-4c68-a20a-322ba0e46344', true);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', 'c6308cac-c900-472e-a60f-76336a232dfd', true);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', '8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', false);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', 'd5097cb9-e315-48cb-ae0d-c3f825216ae1', false);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', '030c326e-b624-4f7f-8735-779e4ef5733c', false);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', '2bf591c3-1a81-45c1-a79f-3a15d908ab43', false);
INSERT INTO public.client_scope_client VALUES ('f1d8a8e0-757a-4cd0-8364-16ca87b02f37', '4aaf5956-dbfa-448f-a54b-b013cea9449a', false);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', 'ec75baec-3f28-4316-a77b-270b14aaebcb', true);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', '922c2c89-57b2-49a4-abff-11db6e2fb952', true);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', 'e97bffb3-edcd-4cce-a59f-32226a722aa8', true);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', '636624a3-b62d-416d-8db1-61554f390979', true);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', '04514393-724d-4c68-a20a-322ba0e46344', true);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', 'c6308cac-c900-472e-a60f-76336a232dfd', true);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', '8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', false);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', 'd5097cb9-e315-48cb-ae0d-c3f825216ae1', false);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', '030c326e-b624-4f7f-8735-779e4ef5733c', false);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', '2bf591c3-1a81-45c1-a79f-3a15d908ab43', false);
INSERT INTO public.client_scope_client VALUES ('0520d506-78d7-4fd5-8a2c-a0954eecc0ca', '4aaf5956-dbfa-448f-a54b-b013cea9449a', false);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', 'ec75baec-3f28-4316-a77b-270b14aaebcb', true);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', '922c2c89-57b2-49a4-abff-11db6e2fb952', true);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', 'e97bffb3-edcd-4cce-a59f-32226a722aa8', true);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', '636624a3-b62d-416d-8db1-61554f390979', true);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', '04514393-724d-4c68-a20a-322ba0e46344', true);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', 'c6308cac-c900-472e-a60f-76336a232dfd', true);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', '8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', false);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', 'd5097cb9-e315-48cb-ae0d-c3f825216ae1', false);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', '030c326e-b624-4f7f-8735-779e4ef5733c', false);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', '2bf591c3-1a81-45c1-a79f-3a15d908ab43', false);
INSERT INTO public.client_scope_client VALUES ('c228b077-1433-4c33-b76b-12fe426d2f41', '4aaf5956-dbfa-448f-a54b-b013cea9449a', false);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', 'ec75baec-3f28-4316-a77b-270b14aaebcb', true);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '922c2c89-57b2-49a4-abff-11db6e2fb952', true);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', 'e97bffb3-edcd-4cce-a59f-32226a722aa8', true);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '636624a3-b62d-416d-8db1-61554f390979', true);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '04514393-724d-4c68-a20a-322ba0e46344', true);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', 'c6308cac-c900-472e-a60f-76336a232dfd', true);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', false);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', 'd5097cb9-e315-48cb-ae0d-c3f825216ae1', false);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '030c326e-b624-4f7f-8735-779e4ef5733c', false);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '2bf591c3-1a81-45c1-a79f-3a15d908ab43', false);
INSERT INTO public.client_scope_client VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '4aaf5956-dbfa-448f-a54b-b013cea9449a', false);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', '768a4ef6-c078-448b-a7bf-8eab89b0d4d6', true);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f', true);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', '87b55b00-2895-4c6f-b55e-d724a97f3c2e', true);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', true);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', '334b3943-1d2f-437b-804e-17e81664d2d6', true);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', '6b9e8638-69ce-4b28-99e2-7d87f5f78da6', true);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', 'ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', false);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', '3196be8c-060c-48f3-acf7-e2114a5d0f17', false);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', '51d9887b-6ccb-4474-bd51-7ee28b53dfef', false);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', 'a6926d37-9345-4ced-baa7-de2a208f9e50', false);
INSERT INTO public.client_scope_client VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', false);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', '768a4ef6-c078-448b-a7bf-8eab89b0d4d6', true);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f', true);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', '87b55b00-2895-4c6f-b55e-d724a97f3c2e', true);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', true);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', '334b3943-1d2f-437b-804e-17e81664d2d6', true);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', '6b9e8638-69ce-4b28-99e2-7d87f5f78da6', true);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', 'ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', false);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', '3196be8c-060c-48f3-acf7-e2114a5d0f17', false);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', '51d9887b-6ccb-4474-bd51-7ee28b53dfef', false);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', 'a6926d37-9345-4ced-baa7-de2a208f9e50', false);
INSERT INTO public.client_scope_client VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', false);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', '768a4ef6-c078-448b-a7bf-8eab89b0d4d6', true);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f', true);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', '87b55b00-2895-4c6f-b55e-d724a97f3c2e', true);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', true);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', '334b3943-1d2f-437b-804e-17e81664d2d6', true);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', '6b9e8638-69ce-4b28-99e2-7d87f5f78da6', true);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', 'ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', false);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', '3196be8c-060c-48f3-acf7-e2114a5d0f17', false);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', '51d9887b-6ccb-4474-bd51-7ee28b53dfef', false);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', 'a6926d37-9345-4ced-baa7-de2a208f9e50', false);
INSERT INTO public.client_scope_client VALUES ('61790db7-d140-473c-ba70-cd70494f4460', 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', false);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', '768a4ef6-c078-448b-a7bf-8eab89b0d4d6', true);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f', true);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', '87b55b00-2895-4c6f-b55e-d724a97f3c2e', true);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', true);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', '334b3943-1d2f-437b-804e-17e81664d2d6', true);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', '6b9e8638-69ce-4b28-99e2-7d87f5f78da6', true);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', 'ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', false);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', '3196be8c-060c-48f3-acf7-e2114a5d0f17', false);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', '51d9887b-6ccb-4474-bd51-7ee28b53dfef', false);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', 'a6926d37-9345-4ced-baa7-de2a208f9e50', false);
INSERT INTO public.client_scope_client VALUES ('3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', false);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', '768a4ef6-c078-448b-a7bf-8eab89b0d4d6', true);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f', true);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', '87b55b00-2895-4c6f-b55e-d724a97f3c2e', true);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', true);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', '334b3943-1d2f-437b-804e-17e81664d2d6', true);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', '6b9e8638-69ce-4b28-99e2-7d87f5f78da6', true);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', 'ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', false);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', '3196be8c-060c-48f3-acf7-e2114a5d0f17', false);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', '51d9887b-6ccb-4474-bd51-7ee28b53dfef', false);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', 'a6926d37-9345-4ced-baa7-de2a208f9e50', false);
INSERT INTO public.client_scope_client VALUES ('1fa89201-57a9-4c55-8d85-46f85ec5dff3', 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', false);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', '768a4ef6-c078-448b-a7bf-8eab89b0d4d6', true);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f', true);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', '87b55b00-2895-4c6f-b55e-d724a97f3c2e', true);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', true);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', '334b3943-1d2f-437b-804e-17e81664d2d6', true);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', '6b9e8638-69ce-4b28-99e2-7d87f5f78da6', true);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', 'ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', false);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', '3196be8c-060c-48f3-acf7-e2114a5d0f17', false);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', '51d9887b-6ccb-4474-bd51-7ee28b53dfef', false);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', 'a6926d37-9345-4ced-baa7-de2a208f9e50', false);
INSERT INTO public.client_scope_client VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', false);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', '768a4ef6-c078-448b-a7bf-8eab89b0d4d6', true);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f', true);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', '87b55b00-2895-4c6f-b55e-d724a97f3c2e', true);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', true);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', '334b3943-1d2f-437b-804e-17e81664d2d6', true);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', '6b9e8638-69ce-4b28-99e2-7d87f5f78da6', true);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', false);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', '3196be8c-060c-48f3-acf7-e2114a5d0f17', false);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', '51d9887b-6ccb-4474-bd51-7ee28b53dfef', false);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'a6926d37-9345-4ced-baa7-de2a208f9e50', false);
INSERT INTO public.client_scope_client VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', false);


--
-- TOC entry 4240 (class 0 OID 17284)
-- Dependencies: 261
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_role_mapping VALUES ('030c326e-b624-4f7f-8735-779e4ef5733c', '2a8dfd62-5bcd-4c51-bc38-55331d78273b');
INSERT INTO public.client_scope_role_mapping VALUES ('3196be8c-060c-48f3-acf7-e2114a5d0f17', 'f0883d03-7354-4592-b8a3-8d6f52e44e67');


--
-- TOC entry 4258 (class 0 OID 17520)
-- Dependencies: 279
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.component VALUES ('2f45c5bb-d1bd-4ce3-bbbc-fabe957ea36c', 'Trusted Hosts', 'da831425-93a2-4023-b385-9915e55fffcf', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'anonymous');
INSERT INTO public.component VALUES ('c4fb534c-5b9d-4f96-aef4-e57ff0df2de9', 'Consent Required', 'da831425-93a2-4023-b385-9915e55fffcf', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'anonymous');
INSERT INTO public.component VALUES ('b095f999-e6ed-4d09-9601-2293b2eaa50c', 'Full Scope Disabled', 'da831425-93a2-4023-b385-9915e55fffcf', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'anonymous');
INSERT INTO public.component VALUES ('5f76be34-edc0-4775-96d4-bcfab54c079f', 'Max Clients Limit', 'da831425-93a2-4023-b385-9915e55fffcf', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'anonymous');
INSERT INTO public.component VALUES ('3b8d8e6f-abad-4191-b987-a4976635f4ff', 'Allowed Protocol Mapper Types', 'da831425-93a2-4023-b385-9915e55fffcf', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'anonymous');
INSERT INTO public.component VALUES ('b3f98021-0cb2-433f-8bb1-e9408893bec3', 'Allowed Client Scopes', 'da831425-93a2-4023-b385-9915e55fffcf', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'anonymous');
INSERT INTO public.component VALUES ('a1db6288-1b7c-4783-bb12-a92ab80f3064', 'Allowed Protocol Mapper Types', 'da831425-93a2-4023-b385-9915e55fffcf', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'authenticated');
INSERT INTO public.component VALUES ('2de3b0a4-c7a4-4c58-bcb5-5270052a2b89', 'Allowed Client Scopes', 'da831425-93a2-4023-b385-9915e55fffcf', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'authenticated');
INSERT INTO public.component VALUES ('9cad3505-f25b-4cc6-9a8a-8cacc9ec3081', 'rsa-generated', 'da831425-93a2-4023-b385-9915e55fffcf', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'da831425-93a2-4023-b385-9915e55fffcf', NULL);
INSERT INTO public.component VALUES ('330095e4-15e5-4aee-a0ca-37319e5c1c62', 'rsa-enc-generated', 'da831425-93a2-4023-b385-9915e55fffcf', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'da831425-93a2-4023-b385-9915e55fffcf', NULL);
INSERT INTO public.component VALUES ('9b470379-b83a-4ad4-be4c-dd26f3227b63', 'hmac-generated-hs512', 'da831425-93a2-4023-b385-9915e55fffcf', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'da831425-93a2-4023-b385-9915e55fffcf', NULL);
INSERT INTO public.component VALUES ('7ec62264-4466-4df0-a0eb-f9af074f36ab', 'aes-generated', 'da831425-93a2-4023-b385-9915e55fffcf', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'da831425-93a2-4023-b385-9915e55fffcf', NULL);
INSERT INTO public.component VALUES ('577b9afc-e893-4bb2-a44d-290645b3fd68', NULL, 'da831425-93a2-4023-b385-9915e55fffcf', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', 'da831425-93a2-4023-b385-9915e55fffcf', NULL);
INSERT INTO public.component VALUES ('81404e32-c4c3-4f7b-9856-e7f1ae1b4ac3', 'rsa-generated', '0eb506ab-27da-48e4-8527-269495758e81', 'rsa-generated', 'org.keycloak.keys.KeyProvider', '0eb506ab-27da-48e4-8527-269495758e81', NULL);
INSERT INTO public.component VALUES ('fb7d9ff9-e523-4595-9557-fd9b7513e20a', 'rsa-enc-generated', '0eb506ab-27da-48e4-8527-269495758e81', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', '0eb506ab-27da-48e4-8527-269495758e81', NULL);
INSERT INTO public.component VALUES ('7976f3cb-5165-4ef4-a2b0-8a76dc243e93', 'hmac-generated-hs512', '0eb506ab-27da-48e4-8527-269495758e81', 'hmac-generated', 'org.keycloak.keys.KeyProvider', '0eb506ab-27da-48e4-8527-269495758e81', NULL);
INSERT INTO public.component VALUES ('afad4d95-61db-4819-b89e-ec63d8ce6c12', 'aes-generated', '0eb506ab-27da-48e4-8527-269495758e81', 'aes-generated', 'org.keycloak.keys.KeyProvider', '0eb506ab-27da-48e4-8527-269495758e81', NULL);
INSERT INTO public.component VALUES ('8c8d31bf-49be-49d5-9868-99d976383109', 'Trusted Hosts', '0eb506ab-27da-48e4-8527-269495758e81', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'anonymous');
INSERT INTO public.component VALUES ('b4434d35-cacf-423b-acd4-c27c4a108175', 'Consent Required', '0eb506ab-27da-48e4-8527-269495758e81', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'anonymous');
INSERT INTO public.component VALUES ('dbe5b35e-5d16-4f15-ac87-001f09512970', 'Full Scope Disabled', '0eb506ab-27da-48e4-8527-269495758e81', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'anonymous');
INSERT INTO public.component VALUES ('cc517ef5-6031-4abf-878a-083b6042bf96', 'Max Clients Limit', '0eb506ab-27da-48e4-8527-269495758e81', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'anonymous');
INSERT INTO public.component VALUES ('2e0eea4a-b7eb-4e75-a810-d99fb7c11117', 'Allowed Protocol Mapper Types', '0eb506ab-27da-48e4-8527-269495758e81', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'anonymous');
INSERT INTO public.component VALUES ('34136604-93b1-4dc3-875a-b3b203b025a7', 'Allowed Client Scopes', '0eb506ab-27da-48e4-8527-269495758e81', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'anonymous');
INSERT INTO public.component VALUES ('0e5b6986-98fb-4503-8617-64ea823b7c4e', 'Allowed Protocol Mapper Types', '0eb506ab-27da-48e4-8527-269495758e81', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'authenticated');
INSERT INTO public.component VALUES ('ba77f864-a6ed-4076-8336-00e9239f0bcf', 'Allowed Client Scopes', '0eb506ab-27da-48e4-8527-269495758e81', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'authenticated');


--
-- TOC entry 4257 (class 0 OID 17515)
-- Dependencies: 278
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.component_config VALUES ('ef8728b5-6447-4abe-a79a-7044e650363a', 'b3f98021-0cb2-433f-8bb1-e9408893bec3', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('d74533c1-1a51-432e-9d17-da826ae7ef99', '2f45c5bb-d1bd-4ce3-bbbc-fabe957ea36c', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('e0bfb891-366e-4ff4-9061-6ae95e288b80', '2f45c5bb-d1bd-4ce3-bbbc-fabe957ea36c', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('ed081702-8216-47c9-9a03-dafc0de955a0', '3b8d8e6f-abad-4191-b987-a4976635f4ff', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('be8d1e52-17ec-43a2-b476-007c532538f4', '3b8d8e6f-abad-4191-b987-a4976635f4ff', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('1ea05651-b2f7-4b31-9175-ffeef90d9d1e', '3b8d8e6f-abad-4191-b987-a4976635f4ff', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('1c98fe77-673c-471a-9587-dd8b25ba482f', '3b8d8e6f-abad-4191-b987-a4976635f4ff', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('ba9f29a0-fb0a-47a2-a3f6-90bd168fee8f', '3b8d8e6f-abad-4191-b987-a4976635f4ff', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('2c20d1b1-b041-46e3-9266-23f5d620f2d1', '3b8d8e6f-abad-4191-b987-a4976635f4ff', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('8097f5c4-ce8c-4f01-b8e0-40d96766a915', '3b8d8e6f-abad-4191-b987-a4976635f4ff', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('637d5088-7a9d-436e-b533-2e980c4dae5e', '3b8d8e6f-abad-4191-b987-a4976635f4ff', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('104b265a-b4bf-4557-b1ce-e57e43e8f3eb', '5f76be34-edc0-4775-96d4-bcfab54c079f', 'max-clients', '200');
INSERT INTO public.component_config VALUES ('3ea4277c-94ba-4783-83a2-4d5df156c227', '2de3b0a4-c7a4-4c58-bcb5-5270052a2b89', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('cfde24ca-ba32-45fc-9c53-221573789252', 'a1db6288-1b7c-4783-bb12-a92ab80f3064', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('814212cb-feba-470a-9068-9545b29ab41d', 'a1db6288-1b7c-4783-bb12-a92ab80f3064', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('e65105a9-35f0-430d-b060-b59b106a5e1e', 'a1db6288-1b7c-4783-bb12-a92ab80f3064', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('890021e9-5b49-43c5-9677-8fdb0bbe821b', 'a1db6288-1b7c-4783-bb12-a92ab80f3064', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('5ec5b45a-6694-4ba0-b580-16396b7288cf', 'a1db6288-1b7c-4783-bb12-a92ab80f3064', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('4e96a568-d8d2-4d65-9cb7-cd5e499471b7', 'a1db6288-1b7c-4783-bb12-a92ab80f3064', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('f541cc3b-68a4-4f91-9fbe-0f03520183a0', 'a1db6288-1b7c-4783-bb12-a92ab80f3064', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('0a2df466-951a-4102-915f-257e084820d2', 'a1db6288-1b7c-4783-bb12-a92ab80f3064', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('ccebfc88-496d-4bd8-a5d5-d62c11464e21', '7ec62264-4466-4df0-a0eb-f9af074f36ab', 'secret', 'rZfsv4QVfRV2_mYG9EBGfw');
INSERT INTO public.component_config VALUES ('0e858b0f-476b-4d10-b59c-8f5d766b4b66', '7ec62264-4466-4df0-a0eb-f9af074f36ab', 'kid', '856fdaf3-6022-4262-8da6-39a40a1919e3');
INSERT INTO public.component_config VALUES ('18586696-0986-4ab4-90aa-596da9c3b8d8', '7ec62264-4466-4df0-a0eb-f9af074f36ab', 'priority', '100');
INSERT INTO public.component_config VALUES ('f7c412ae-6637-49de-ac0f-297373bc032b', '9b470379-b83a-4ad4-be4c-dd26f3227b63', 'algorithm', 'HS512');
INSERT INTO public.component_config VALUES ('5a9c53b7-1793-4cf0-b5aa-08b030d0d0fd', '9b470379-b83a-4ad4-be4c-dd26f3227b63', 'kid', 'd5624b49-0f15-4b9e-a92e-2ea2e019d66d');
INSERT INTO public.component_config VALUES ('c0fcf4a7-f6b6-42c1-afc3-dd79a9199e92', '9b470379-b83a-4ad4-be4c-dd26f3227b63', 'secret', 'M7kjML0tAbx9aPGjWNv5beZ_8FB4G44SizCw5gFQa-46cs2XkW4OrNc-Ql_fGX3MAKTMJhdBgb_HZFGRd87u4DqlT1X_N73oVB8DoXTAfbr3t4lpEGWHrKf7OZVG--UwtI4j24Q4aizpx9nIlwGGMQQ908uOp7i8tzctbkznWqA');
INSERT INTO public.component_config VALUES ('876343eb-1059-4938-ab65-af09c18d6069', '9b470379-b83a-4ad4-be4c-dd26f3227b63', 'priority', '100');
INSERT INTO public.component_config VALUES ('3f5e165b-5146-41e3-b29a-d15c5f9325b7', '9cad3505-f25b-4cc6-9a8a-8cacc9ec3081', 'keyUse', 'SIG');
INSERT INTO public.component_config VALUES ('096b227b-0735-4a65-87cc-15102289bddd', '9cad3505-f25b-4cc6-9a8a-8cacc9ec3081', 'privateKey', 'MIIEogIBAAKCAQEAiYrDFAacSFfYHPc89yQV5pa0Otv0ihiF+QLuPgv0XzCmoTSlqbLo2YqIvOdppkrLUAO5ETYQUZhbpUioS+AOOi8yaB6FSqLBGoRNMbUbSoQiD4tS7lmA53lUpWzkH2ejAn4PSDscJOTQaaLqDzdkHVo6YKd2cMMwhsl4rBuFbAk86GZAgGVnxiLH0gsOmqCmsfWMUrjSRdZVEYAZ4788JNce/hSmBRS47WOYsKsmcpvZzijFIe9TwrKkB+CeDbOjzLBpQpJM6W+tM3CiElbPTjRDacL9BC5+IN5Pbank7cR/pzjxdet8o0J+RbCO6C+tXjMtnyCDJILF5LvGp22TjwIDAQABAoIBAAabT7uKhb9D2PGrPpZweUzWOFoLbrejbewEJAV+9YINCDP+H2cDXQP2D5NjWkPOm+2AAEe/XRFOTDioQM1EOeq5kaZGsQhgwP3RFRQqKuFtb2Vnv9gLHJIB1fsMO/j2NXJNM9a4YCW1h/1LAgsxEfIG/37dDGdmONKAovdBaytBRFCNjFLk/FhHsDREpgkh+C0B6fl7MmpBScM/XmrYi90Jduj2C2ixDdCl2TyS1m152m6vJD6h2Ly7DrO6Np/do15zI41ClSyYcriq4GMyplj5U4vpvEkolafSK5yzq6RMygI/QE02eGVQnY/CpVj2NFGi0/g/vqiRbS+Yu4hBSGECgYEAvZ/6zyev02hvWdS3AxPBfuEtTxcYvxqoaFWNuMq3fJGNyxnmOUGwJSDEHafBH4it5XC/vrLklFUKego/A6Yp71GOrKXdmCY0QmK8C1QzgEer1MrIqBBjvgG0XZrXPK/25XWc3eSdclOJQZmRHaViRWBbVnZ7GoLE0nS/U/DfTUMCgYEAua+1iWG193msO+Yp5VLTVr1rnZEUiSEeooaCBS/icgdONhfS/Ur/3DMdic0ONwfVPYKwrNX8z87vH1rp810bfs05pSi7A4xzv0yCaLVu+YGEfIHsVBD/N8tBFgWgNb5BiqiP1WZ3i8rsuTnuO/Iq/AJ3bN2HPvhC2agaxUFi9cUCgYBKeSlc8J5KbkrFQhi6eajV9wP/eve6HnMjvu4RNHSJ1PSWXs6fkB/pBQxhBUCA7QI3CWgVMlc5toiN07ZZ7YmstyBMyDvWhLKjm/l0jZZIfF2NDjNuZjl2J186IBUGfal/Bwkb0KzReOOAQxrOROTqkGRu+ctxZwh8C2QVSJW61wKBgGLBP3RkYinPLTniLHAJf9rG/UAc0+YmlitsDCSEFhP9LKx6OT17MN7E1LXgN+ouoUuIgTw6xq0i6mwrpvdGkoP60+ix49x8S2b3YvgbXn0WVAb/9lezfnkHAYOb1Fwg5qy+/1hImdXgQ8wzMi/xmMjU6v0cSHzF/o/R5wL3xpDdAoGASMYq4dMkvi+6MlzMUybWglhkVHNClznrtz+CgY5TMT38kgZio+FR5n05DpgiKII8YMYUpVS6gr+e1ZwHceedHJh7oZ3jrz912nMl415RPHEmvjvcuZiiVxumMvTY76jEG/aJimlsLiLgh7zOvkbtLp4x80ty6Uvsr8t+xE0TwkA=');
INSERT INTO public.component_config VALUES ('394f8810-abb9-42b0-b4ad-485859a1d81a', '9cad3505-f25b-4cc6-9a8a-8cacc9ec3081', 'certificate', 'MIICmzCCAYMCBgGYa3SR4TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODAyMTU0MjM4WhcNMzUwODAyMTU0NDE4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCJisMUBpxIV9gc9zz3JBXmlrQ62/SKGIX5Au4+C/RfMKahNKWpsujZioi852mmSstQA7kRNhBRmFulSKhL4A46LzJoHoVKosEahE0xtRtKhCIPi1LuWYDneVSlbOQfZ6MCfg9IOxwk5NBpouoPN2QdWjpgp3ZwwzCGyXisG4VsCTzoZkCAZWfGIsfSCw6aoKax9YxSuNJF1lURgBnjvzwk1x7+FKYFFLjtY5iwqyZym9nOKMUh71PCsqQH4J4Ns6PMsGlCkkzpb60zcKISVs9ONENpwv0ELn4g3k9tqeTtxH+nOPF163yjQn5FsI7oL61eMy2fIIMkgsXku8anbZOPAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFGzgub2Y4Zb0Kb6EfpgkK4sgAxG6gD7cZnd7+1SH55B2UT/wklQ/0uDyLs3NJTnlvUD8yHHtFJ8T3Z5jP48Ss/1faYmlLn8nvQAkj9/gSSJShG7ONKD0No0gSK0URZDlNmI2Or96xHK/ogMQZpa3tIschqp5BrCePsKR5AN+9VKNPo5g5LKmjDtmfbQv6qlFAro3Egtg12EEBfbxkMs+2YRWVJ4HAt/2mC4ucckj3J2ZUnQg9SuWkmvW+tH8OVJ5+LlRaNoqfuzmZE/Kvir9YVTQd4VeewqL6XIahIkTYLlhMIswx1/Yp3CAET3OMHcAtSozaD7Bes48sidlv924x4=');
INSERT INTO public.component_config VALUES ('2848a4f4-7364-4609-a853-cc7987d47e4c', '9cad3505-f25b-4cc6-9a8a-8cacc9ec3081', 'priority', '100');
INSERT INTO public.component_config VALUES ('ecdace22-ee17-45a6-bd0d-084c6bc4a21f', '577b9afc-e893-4bb2-a44d-290645b3fd68', 'kc.user.profile.config', '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}');
INSERT INTO public.component_config VALUES ('98f1affb-418c-439c-84d8-94210753702d', '330095e4-15e5-4aee-a0ca-37319e5c1c62', 'certificate', 'MIICmzCCAYMCBgGYa3SSJjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODAyMTU0MjM4WhcNMzUwODAyMTU0NDE4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDZPjhvVd+dfVsGZVzRRuJzTnxmS50U7l1dSBLK4I1aqvTiorvmt9nL9NoNReBkOr/+8TdoGmnvIFHAU+07DJ7y4syb0n7B5K4Qqw+nwJZaYIszM08T4C+bPnTgHVofUdkOsk3QqonK7qU5RiGjHPtkhXGovNgBamDIK7yU8lmrwcdjYg2r5CYwdPgm8JCtMK383+D74f/gRcgWtFbMUqDDHVdt7YeZeUvN4OlF7UcSr0iq1aAhx1PWPfVFT8SQPLi+VhGkaIXtjkfePyc1c+UGGRBC1o/uUEa5oOnuGHtrwU8R2oXR456lLi92ut9dx5tKv+VUoWuA1/6UD5zwJ3rlAgMBAAEwDQYJKoZIhvcNAQELBQADggEBANkeU3mFWn0SIMzcoimhwUwL9173RUS/8ktQWwTs4KZCkpMskFAu9vrL+u/caZkKA82F1HrSNJPzubiE/BAOfAK8jq9K+spSWAd8SjsSokwqLX0mZNz1ghQRCZUBl4pMnXNZJerDQEKon7EWthGMGw1pdc3aPaEMm0N3BjEOBrPUvi6/pucmWErmZkrx6/0khStqXmt76ZWl5gW7UCUSHSorhq3dMJqjUaRxtbS1RUQJAATo3avk/qEdWRIgqT2BHP3WaAx3AWAN8YMekzqSHGMq0nyYqbFzIOoxXyZkzy8yf4WrHXnW96xmuMZ0k2Jpi+eIYMwhadqdRs//MK75FlA=');
INSERT INTO public.component_config VALUES ('e829c4a8-9662-400c-82e4-58b971fde4af', '330095e4-15e5-4aee-a0ca-37319e5c1c62', 'keyUse', 'ENC');
INSERT INTO public.component_config VALUES ('6aaf588c-f3f7-460a-b92d-78b56ee2953f', '330095e4-15e5-4aee-a0ca-37319e5c1c62', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config VALUES ('9d855b95-4b72-4a7a-9f77-2cb1c9ff87b5', '330095e4-15e5-4aee-a0ca-37319e5c1c62', 'privateKey', 'MIIEowIBAAKCAQEA2T44b1XfnX1bBmVc0Ubic058ZkudFO5dXUgSyuCNWqr04qK75rfZy/TaDUXgZDq//vE3aBpp7yBRwFPtOwye8uLMm9J+weSuEKsPp8CWWmCLMzNPE+Avmz504B1aH1HZDrJN0KqJyu6lOUYhoxz7ZIVxqLzYAWpgyCu8lPJZq8HHY2INq+QmMHT4JvCQrTCt/N/g++H/4EXIFrRWzFKgwx1Xbe2HmXlLzeDpRe1HEq9IqtWgIcdT1j31RU/EkDy4vlYRpGiF7Y5H3j8nNXPlBhkQQtaP7lBGuaDp7hh7a8FPEdqF0eOepS4vdrrfXcebSr/lVKFrgNf+lA+c8Cd65QIDAQABAoIBAB8p1QwpmCyeKyTZfQ1bWwg58c/12FiEkhmbyXBXcoeXXw401HoWFRT0MKR3Sedu4xRmE3HoWhpuuzN5Bp6yIooKnVncAgl77blf5JzGnHrl/wnu+hDKl+Gv/bGZnFBCXD4Gt3FvyVj2T3bOF+yvb2Od3e5b+quHUE9esMx4EIN6Arh4i9Ocs2RemvglTMZzr7Q8DyCQ4iosGT4FYgn77wlr+OWMbYtLUh5aF31bEVdks1yvT54cj+PuO2nvteyCQaOjL64U0OyzTYo4jlDDnJgxu9b3aB6o+OGFtV0dabgXfNrXskYmb+mFoIzabt4DZ/5Wxo+HQ9kMcsQxiAw6BXkCgYEA/HOAjFXhLIaV4M6Ykyp9ZuAv2UOH50GI6wfm14i6R4GdDN4SWyLqzU7eVAuB+Afyl8IYsWF0ma8ZpO6IF3zM7LU0OxEJYNwc9bbDVPKB7qcgRUxYNq5KsX9eqjTM8Gag1MpTB6Ni5ApWaowZSG/uMdmMTiZTg9fk0V6dbmIvSqkCgYEA3EwDuctAX3gpkh7HMBdMOhBkiZ6T+1UNRvscmZDA1TnuSyIaFkjhmo8m6aFcunJTx2XUcdV0tDCL78Z7iysG5sInbqS7LTkjb3QZxTkYtxKFMuHfl8osP76fmRCYWBsW4WDfYfmhFXJX5Kd0R2kyFKyMuaqvG3bPhf1dGVQHL90CgYAmt4QYgbdF/+IOl0C5GUQgOfO8q2m1Ysyf1xdlKNgAzXULmydPiNxf3l+knhsxse5XrfHhimO6iisxq0994qr/Bo9bG7LHgxqB6KSua37X3hPJ7Pp+cF6OOE2JZw2jNOonmFwBiOJKvPch4hiijmAGjynAdopKZxr1rUARxMch+QKBgQDD+GsoEINHamGwtuiDA3awAH0vX35NCrAxAJnEkly4UjyFYeTLBjKLh+UZ2I3g3mtg6lk+mqCi2rzhpDOq7a/J/9WMO8a2yCmZsDJsnAo8caFETmLVaOhMHItlYrnjRtXn0IFnauW9amZ95ekuzYnbklPtpsT3LY4Wp/j12yY5kQKBgAqd21VCa/iyzmpTJB0nUuMpNMmzHpLj4TI7b40cLUDwT5rQm1nCGLRvT08ihhLfRiC+g+9SXrgGTvHXXCukvouMJ22NlkavHRybHvts+qforV/7bAF/qQRvxmKP62V+jwwVymMLdRRHo2aSNWEX6o5+rrBPJb2LYqyI9LsM08Of');
INSERT INTO public.component_config VALUES ('26a83388-6ef5-4746-884d-6b4bc2e20b59', '330095e4-15e5-4aee-a0ca-37319e5c1c62', 'priority', '100');
INSERT INTO public.component_config VALUES ('f213ef33-478e-42c8-92ee-85981e967f29', 'fb7d9ff9-e523-4595-9557-fd9b7513e20a', 'priority', '100');
INSERT INTO public.component_config VALUES ('cca583dd-292c-4c3d-a347-830147223db9', 'fb7d9ff9-e523-4595-9557-fd9b7513e20a', 'keyUse', 'ENC');
INSERT INTO public.component_config VALUES ('0056f181-08e6-4cd0-a9a5-4289e99f779c', 'fb7d9ff9-e523-4595-9557-fd9b7513e20a', 'certificate', 'MIICuzCCAaMCBgGYcTHGBjANBgkqhkiG9w0BAQsFADAhMR8wHQYDVQQDDBZyZWRpcmVjdC1sb2dpbi1leGFtcGxlMB4XDTI1MDgwMzE4MjcyNFoXDTM1MDgwMzE4MjkwNFowITEfMB0GA1UEAwwWcmVkaXJlY3QtbG9naW4tZXhhbXBsZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM7eus1R8xmEI4CxcPOjWbm1yztOCJgmigf4PQD8CGzMxC82ZvEomUxH3g5kQEewGgQSjIubDu1I7f2SUGl+zqpspSCiqtV/G5S0rz0y9oSVJjdEF6yx3kaYE4Z+GjBPCB4F7FNSYFiy5rfN10DRix31qQ8xxVkMuN5fe2xGmAOysviJfEtb2NPytIUEVF3yeUmpAnAlRNCyh4aMWFDqIxHqGjelftH9NGXUKVv1Wg+M1WfiZGzRHIst/FHrc5M6T2ftNLw3uQFzBHqFzcczkWgUH45cOpwL9hd/2jbWk8WHrY4ILqd3S1umbivuYe5Aye6YA9ccvwvKvfZ5T+7kp5cCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAcDYH3USfKFgl34ySrblA7WN5bup1gqP2PA5gsX/yvzsgZkfZ4CR4zogOVHwvi1fRRt3qXkwTh38cx4Tj5iflMPj5PVXfYc1ZWexS1N30HqCiwSDxpv3zry8bo5WECbd+RzyXrnx/It2v//qpH4SJdlRDMH77eAo9hx9I4mC7TEnFNmUfL2hQ1B+YHmghRR1Vhibue56LRjM2Mt5131/Pz+ZVRxfL/1HyYbKRjRCF1E7+cO/pS6laJnQnCIWSgTA7uyPY4EufAHCxBpvlak5EH2OnI3IDMpPUeB0ZDxVGjS3XJIuWnZHtdNa77z2DqlTRT7tmJ0Cwb3Z8DDc36h01QQ==');
INSERT INTO public.component_config VALUES ('10934701-a356-4f34-b8c5-f674bc38f1f0', 'fb7d9ff9-e523-4595-9557-fd9b7513e20a', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config VALUES ('4488c85a-0885-45c9-858f-0852ce24caed', 'fb7d9ff9-e523-4595-9557-fd9b7513e20a', 'privateKey', 'MIIEpAIBAAKCAQEAzt66zVHzGYQjgLFw86NZubXLO04ImCaKB/g9APwIbMzELzZm8SiZTEfeDmRAR7AaBBKMi5sO7Ujt/ZJQaX7OqmylIKKq1X8blLSvPTL2hJUmN0QXrLHeRpgThn4aME8IHgXsU1JgWLLmt83XQNGLHfWpDzHFWQy43l97bEaYA7Ky+Il8S1vY0/K0hQRUXfJ5SakCcCVE0LKHhoxYUOojEeoaN6V+0f00ZdQpW/VaD4zVZ+JkbNEciy38UetzkzpPZ+00vDe5AXMEeoXNxzORaBQfjlw6nAv2F3/aNtaTxYetjggup3dLW6ZuK+5h7kDJ7pgD1xy/C8q99nlP7uSnlwIDAQABAoIBAATRM4wv1T3dKyh5hhxRfvevz78E46ok9GZ+gm+N7uV9sf0GQsjPcOmeUmggyU01QOQ8Yr2msc1juxFop7e1LLttbHD0m/UwKj4nV123XJc2YLcjvkgwTvFAF4a0hztkJvFWb19HVhgERN9RC0Smouf8ZJOGgKzaR3z7wARQjOsOr19HjE9IlWDdb/OIElHDO3NKA7qHqtF8ZExZnseLtAWQ2EcuU1nWyFO20ipll/nMLEFpFRACOo0/Uk2e8+PCzqq8GTwskuPHz3Hjlsd20duNSOH7hQ2qYs2EUGWVWhMVJm5nAPriGFusLciA3OyYKbHAuiLSLwttNlVlX45AzoECgYEA+f0qYBdUcnGaINevQEmCeKlTNvgstlobNnfcd/K7FyGFv3buzTxYbAwmO9MKisgO5zFqNiXp+zwBnpNw6L53vGgdiWoHgCzZgxj2Ozq2AmoPwVioKDVNMhADlUdLnvNGWkxnNvzDc+bEGd7KTgEbeO2KSt/EpHYlnNBK8cPtV4ECgYEA09gkHXS/RlYQcUtDWxCjQ5Zxo1GxCZkYWdcgNlPexJnfjtWMHSrMqXfu3dBZ4VBKX2lsx0gC7rzALVd43PD+FiMx7JioYsZsx5Eg4YhHuYEa23Bl4OsO3uKck0Hy+9xmWEetuCBH+QuMjOtRxInXWV9B1/mFhNngFS/1rVtvSxcCgYAWxrUcqiN8hdMoGN6Tud7URYEaagQQ3SbLkKIan5fiJKC98AUT1+KqfXTiUHkOaenJsJvfsRafWDlBjGdmHSxlkwrV4T4rtGpg4l5UySWaFLW4xO4VM74DyKe66xL9uWZ4hauFvAPGxIirXrwJ3Vn2a5YE+lw9K7KDlgqt+k7egQKBgQCWHvLo1NS/GToprvYaUF4CBVieLcPRU2ZINASluyWAGLKt23KhMLU72ruxAHbRDj7GAkWNquA5IhTljLkfiL/mHCbCzSN2a7qmaZftes+pC25m1u27R5eQJvJiADgadwMnyBO5CVc3ixGcwx18s1miAbj9Pdt6W5NKMGRe5w6lHQKBgQDVh2JFRiGCmBR9X/wwX02gPNTz+1/69Avalquq/VGSrmi+65b40tqztb8dtRrBb3tFcfVDYcH4HBD/uEUdetj7RO3Wg6fDF4HqGJPVo+iVOqrhIztgFkOnF4P7V5dqknvSnLA+Uqf+Dd5GpvmGoWf33XTKB3Oc7pHFQ/RgjCKSUQ==');
INSERT INTO public.component_config VALUES ('1a38ceb8-9e2b-4d7a-a58e-140a909d1428', '7976f3cb-5165-4ef4-a2b0-8a76dc243e93', 'algorithm', 'HS512');
INSERT INTO public.component_config VALUES ('d9d0455d-dc0a-4d0e-b966-6d639283653a', '7976f3cb-5165-4ef4-a2b0-8a76dc243e93', 'priority', '100');
INSERT INTO public.component_config VALUES ('74c75492-4801-4571-aac9-75e7e598780c', '7976f3cb-5165-4ef4-a2b0-8a76dc243e93', 'secret', 'uBbO5lR_DIdJy4Cs3tfkNhtvRQGH6N5RH6VKHrRZWHanLYGNOG-LCNfpIaQvtLkI0Gy-UIFFrw_X37dO_F_VPgz2uwMpbmo4zGBobK3QZglLzSOq6YNSw4rNp1P55NhiH37kE1Wt0giaAo4j0N2LjI73jcUC1hWd1OhWKruSAAw');
INSERT INTO public.component_config VALUES ('f0e48555-edc5-42ef-b55c-2050434565cc', '7976f3cb-5165-4ef4-a2b0-8a76dc243e93', 'kid', '577cb756-af7c-4491-9476-7f0d957c2bf6');
INSERT INTO public.component_config VALUES ('497c49f6-89d2-4f8e-8abe-a83b86c444e5', '81404e32-c4c3-4f7b-9856-e7f1ae1b4ac3', 'priority', '100');
INSERT INTO public.component_config VALUES ('8b026ed3-b1ce-4054-99f0-b8d61970194e', '81404e32-c4c3-4f7b-9856-e7f1ae1b4ac3', 'privateKey', 'MIIEowIBAAKCAQEA5YSrmbsKzs79pSnNoYMHAJoLtkfanw09daqE7g6OGHxStD1EqPNjEoZbNep+i7crye0O5d5LdM6uADkDVLtMR7kqiJCmQ+hBAvlfcdokmc/WcqdcHqOOV8MmG8PJ7xE29Ck4HMcp80OA6+0XIdbEijPMt+17iE6X/cqcsMhAeD3saVH48W0GCoIyu9RLHfoyEkYxerOU81j8VFUNs6LK0on07+7ElA+z4m+xFoVoUbi0VxJUUrKa1LgGhFJ1NJkS7bdH4fCSuwXt60k5ilYX/+J7z9/U0rgFLzuSbXJSWx6VcM6W2mY2k/o+7lpnHVAsPdfPX8gGlDu/e2BMhGzZxwIDAQABAoIBABlBj88wiZBCWh+k9E9z51RbSd36wDBFDmChV/6ziVK2c4oJPUHzg7u+dHuqsdbWsYcx197W/FSpMvUr+5WFBXArDGbPYWG9mqcky9Tvx/FJBp8X6DIoQKSgVn7dp53wC1ezeszn5FI0ORPnw2Y3h5RxqMhgkKRqNEglgI06K/tPF8GaomJbTXvj5DYd1ZbNvYZ4p2lJpvbywhkmsmTy9HhZrTpCaUJxzWAmjJAPyLcVbQPo9VuUgBCTnMecbgloUAk2dHXFQXxENsHOYixAyvu53Npijiwj14+60Dxq50GwvTfBNCgdBzz9Ydh8kkOgKLQibFmzUCMQXp58QMmo/AECgYEA9mr0TFsZjp+xkHX8A1tD/1IXLl/c1/dGd4xBeGVokJ3l4Ot6sN9+zEE/abXiPyq/jcOWkBxW3pb01EbypWs6XV211GeMobo/BxrjWewQsW/UNLCOA/kPjDFY822tbJyQLumt5Cu3CGDLYnKN9ejrfDqYLGIHmYo9mjr1lp9AagECgYEA7nF76DZfxzK6AZWztEFke19Hi6HiB4tyaLe4G+08AtRmiiIqkNdN+UYaciSM72DCUIXaaBNo3tBJQnpjUJdRMUEosCLfyPRdApiyUDgV1jKMLj3DLUAm+Xx1OqxnKKAQR3wq45lnD0THppEVJqnjfJbbU2BmnB6lfpfvlPG8c8cCgYEAqL91rRR13AXgQ12Ix4OofSBqX4emZP8hcpzJ+Pj5Mo/u7KhVzOpAmv/TvUChP0C3DQ3z/ZxqoOQfpX8wi7dysJ2L93kyBU7V+refGeVfSSOb3rlJh873prnkgE+Lg+Vzl6zPOIH3RfWDUlfAf7aSDPDTZRF8wti4dvYJWKyWIAECgYA2m3TWFIXQ1/QzYrZ6JLO/cW2wM83RDoWQJ+sZMjaZK02kevimnTh1SzHJTEeeltlJma4QQcm1pZvxhpfyIAVvM03/MK1xl00pyBCmQIH3wTHLcUeeuF90qaUrX8psSmQQCwbDgyFQJN9YbUebyDKaGO535M77GCWsnV04DjirhwKBgAKV0hXue50BlBg8emjKI5L7sUefSzvqJMvsO7H8dgs0cLU5T9DqSGZw35vKy6sGi1c+MU9cjeWoTTme9CFzjnAO92Gfqn1ERVz0i5pwLe2Zvpsbyv0oViLxtk9sOIPQFA38ETY16xvNNkycWX2++TfN+jJXwiY/oVI4aznlPaTB');
INSERT INTO public.component_config VALUES ('b65b6c31-e663-400f-bc5f-3406cb74726b', '81404e32-c4c3-4f7b-9856-e7f1ae1b4ac3', 'keyUse', 'SIG');
INSERT INTO public.component_config VALUES ('7946162c-4850-4012-8a2d-81fb9c6c7bf2', '81404e32-c4c3-4f7b-9856-e7f1ae1b4ac3', 'certificate', 'MIICuzCCAaMCBgGYcTHFtTANBgkqhkiG9w0BAQsFADAhMR8wHQYDVQQDDBZyZWRpcmVjdC1sb2dpbi1leGFtcGxlMB4XDTI1MDgwMzE4MjcyNFoXDTM1MDgwMzE4MjkwNFowITEfMB0GA1UEAwwWcmVkaXJlY3QtbG9naW4tZXhhbXBsZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOWEq5m7Cs7O/aUpzaGDBwCaC7ZH2p8NPXWqhO4Ojhh8UrQ9RKjzYxKGWzXqfou3K8ntDuXeS3TOrgA5A1S7TEe5KoiQpkPoQQL5X3HaJJnP1nKnXB6jjlfDJhvDye8RNvQpOBzHKfNDgOvtFyHWxIozzLfte4hOl/3KnLDIQHg97GlR+PFtBgqCMrvUSx36MhJGMXqzlPNY/FRVDbOiytKJ9O/uxJQPs+JvsRaFaFG4tFcSVFKymtS4BoRSdTSZEu23R+HwkrsF7etJOYpWF//ie8/f1NK4BS87km1yUlselXDOltpmNpP6Pu5aZx1QLD3Xz1/IBpQ7v3tgTIRs2ccCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAA2AFNXtgC3i86I9AxHjDejJ1zZlJ+yYQbCK0O25XGZlfkMpZFN1BWSuc3jQURbH5BO1LOnmslIACFix4I9Yo4qsYSIEr94yVgp4GbzYTghLZuWwWbCV4xv5UF0DNTAmzmd42jkB8XHGljiqYYR5ZRVl6nNuB4/N+bO4BR/fGI+cjut2aYvQrdTDBpH8Graw0723QYu2DVJvl2pjuGZSLWmarc+GOGvSZ37vUe4Xwr6f0jV29BAV65GiD+7l/bW8bZbHxSSG/j0loVIJEnnkdjqlsZcXW8kCAWygoJnSKYmLmSU8AQw8ond3z1rqBJukejhFZYZDxT+1LSSPGP8qo0A==');
INSERT INTO public.component_config VALUES ('85c81f55-ae90-4040-9aef-7165ef6b5123', 'afad4d95-61db-4819-b89e-ec63d8ce6c12', 'secret', 'QEAU5gHbi9pOQSwN4GIdhg');
INSERT INTO public.component_config VALUES ('67d865bc-177a-4703-a73b-3c6ad4a843d4', 'afad4d95-61db-4819-b89e-ec63d8ce6c12', 'priority', '100');
INSERT INTO public.component_config VALUES ('9c7333aa-bcb9-4bdb-8fd5-bf1004e0059b', 'afad4d95-61db-4819-b89e-ec63d8ce6c12', 'kid', '5202d662-4614-4dae-8c60-4189a139b5c0');
INSERT INTO public.component_config VALUES ('6f238d48-2812-479a-b4ea-33ca6a969ddc', '2e0eea4a-b7eb-4e75-a810-d99fb7c11117', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('bce517de-57ac-4f94-a0dd-ffbd49b0900a', '2e0eea4a-b7eb-4e75-a810-d99fb7c11117', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('8232f38d-cd16-4d0d-bd97-1c99cd454454', '2e0eea4a-b7eb-4e75-a810-d99fb7c11117', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('2dba6c93-3a97-47b4-b0a3-6685756ec189', '2e0eea4a-b7eb-4e75-a810-d99fb7c11117', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('36b8f5cf-0cd1-4a82-bb2e-cfdd2e761b61', '2e0eea4a-b7eb-4e75-a810-d99fb7c11117', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('12946065-1ce0-4142-9d4a-533431066a0d', '2e0eea4a-b7eb-4e75-a810-d99fb7c11117', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('5fae7bd9-b5d9-4787-bb53-6b32b054c8d2', '2e0eea4a-b7eb-4e75-a810-d99fb7c11117', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('838653c8-7782-4e92-bc2d-c43dd8856b7b', '2e0eea4a-b7eb-4e75-a810-d99fb7c11117', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('c4069122-4455-4f63-ac00-f79ca435f064', '8c8d31bf-49be-49d5-9868-99d976383109', 'client-uris-must-match', 'true');
INSERT INTO public.component_config VALUES ('1dc4c8e3-6d1d-4bae-9760-496c4a639492', '8c8d31bf-49be-49d5-9868-99d976383109', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config VALUES ('5a1135cc-f094-4a6f-82c7-67b7e81c465f', 'cc517ef5-6031-4abf-878a-083b6042bf96', 'max-clients', '200');
INSERT INTO public.component_config VALUES ('8698bf78-7b14-4883-87dd-e390c6bfd1f4', '0e5b6986-98fb-4503-8617-64ea823b7c4e', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config VALUES ('21f6cbc3-d372-4431-9d59-7a8c78d9e3f9', '0e5b6986-98fb-4503-8617-64ea823b7c4e', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config VALUES ('9fe4bf50-42e7-45d5-a146-056f7ce168b2', '0e5b6986-98fb-4503-8617-64ea823b7c4e', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config VALUES ('54a9cf03-85e8-47dd-b294-fc85d7b3b25c', '0e5b6986-98fb-4503-8617-64ea823b7c4e', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config VALUES ('9ae67867-a4cd-4092-8553-d92a439e2690', '0e5b6986-98fb-4503-8617-64ea823b7c4e', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config VALUES ('bc8b83aa-5826-4a8b-a4f0-e3a8a26d62aa', '0e5b6986-98fb-4503-8617-64ea823b7c4e', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config VALUES ('06e3b6d4-e2e4-459e-b08f-64543a7c7d64', '0e5b6986-98fb-4503-8617-64ea823b7c4e', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config VALUES ('6b9d8324-495d-4b57-a0cc-27a4538267d0', '0e5b6986-98fb-4503-8617-64ea823b7c4e', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config VALUES ('33469e94-744e-4913-ba25-37fffe68e46e', '34136604-93b1-4dc3-875a-b3b203b025a7', 'allow-default-scopes', 'true');
INSERT INTO public.component_config VALUES ('f77baecd-eebc-4745-aa61-7f7995eef0e9', 'ba77f864-a6ed-4076-8336-00e9239f0bcf', 'allow-default-scopes', 'true');


--
-- TOC entry 4191 (class 0 OID 16417)
-- Dependencies: 212
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '0d33ee45-557e-48b9-bf69-e95438d0b825');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'f24d71da-acb2-4fd9-af3f-1e00f89d9eee');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '82a0f02d-f761-4563-95c3-8e7f62c23c7b');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'e6c7a4ff-5a36-4571-b1e5-d7d0bce00875');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '2e71223f-1606-46d2-b506-7559d200fed1');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '634db07f-8e13-45ab-a446-56ea82319f5d');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'd09c3f62-6b82-40e3-ad85-3ba789a0eb70');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'fb09697b-9cb4-46f0-be5e-60fbbf446a2d');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '19f8095a-1865-4a12-be15-8fdafdf75a4a');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '9a958e9c-12ed-45d3-9d49-72ae681d6c9d');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'c0e66f0d-c1cd-4e00-9e6b-f2968b95af44');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'fa28186a-95ba-4ad0-87a4-41907b869fca');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '1335ad1e-d6c3-449c-b0a2-c1a9cec00825');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '52ed5f56-9e37-428a-a691-dc2cc653517a');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '86f37236-6c6c-493c-b239-2c8880a8cdc6');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '26764f1e-4cd6-49a4-8ca4-80c5308e1224');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '8b033e0a-e577-4d50-aa25-34cab36dcb62');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '0006c184-0d08-422f-a823-3a75fb2a9e36');
INSERT INTO public.composite_role VALUES ('2e71223f-1606-46d2-b506-7559d200fed1', '26764f1e-4cd6-49a4-8ca4-80c5308e1224');
INSERT INTO public.composite_role VALUES ('772815db-2336-467c-82d0-bd71fd6f46c7', '11d3da0e-4d82-4d82-b1c2-6747cf3cc8c8');
INSERT INTO public.composite_role VALUES ('e6c7a4ff-5a36-4571-b1e5-d7d0bce00875', '86f37236-6c6c-493c-b239-2c8880a8cdc6');
INSERT INTO public.composite_role VALUES ('e6c7a4ff-5a36-4571-b1e5-d7d0bce00875', '0006c184-0d08-422f-a823-3a75fb2a9e36');
INSERT INTO public.composite_role VALUES ('772815db-2336-467c-82d0-bd71fd6f46c7', 'a132590a-4e6c-44bd-ac4a-16132c79f965');
INSERT INTO public.composite_role VALUES ('a132590a-4e6c-44bd-ac4a-16132c79f965', '36b7c8e6-1793-45ae-b77a-02b273b11fd1');
INSERT INTO public.composite_role VALUES ('68182c8d-de6f-4336-9b50-225e76e14059', '32859c4c-c5ba-46e5-8e82-4d6b1d5b9c8f');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'd621916a-b076-49a0-9620-6e073be054b7');
INSERT INTO public.composite_role VALUES ('772815db-2336-467c-82d0-bd71fd6f46c7', '2a8dfd62-5bcd-4c51-bc38-55331d78273b');
INSERT INTO public.composite_role VALUES ('772815db-2336-467c-82d0-bd71fd6f46c7', '062a3c5b-0d52-4a97-b3d3-e1f9d41cae7e');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'b12b3cba-c56f-4581-980c-4c74c3b14201');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '1f7cd251-6b82-41e6-85a9-6754bee8b256');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '6c2bb1cb-6054-436f-877d-0bc799fd9209');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '415e0428-bfc4-4e75-aa07-f0c4366b7887');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '55e4ab6a-ef80-4166-8778-2b622a8608e6');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'fbd73f91-8ed4-486a-9587-b29d122559ba');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'c9868916-0c70-4cda-b5b2-0fb9b0bd6ffa');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '8e086756-61d3-4138-bb3f-fd0ff41c9381');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '4d8988bb-2eb2-4772-91ff-a53635fe7f00');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'f8368d8b-e1a4-439c-ae3e-c04a653d1541');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'f76fa262-e997-44bc-b4a1-a6745d990306');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'ba9b1193-e683-4f00-9a3f-22ada1af9a87');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'f4490bfa-998b-4ad7-b53f-4fe3d35490a8');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '8f99a4e1-a52d-42d6-9147-3873d52b6f11');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'd629855a-9d78-4a5e-b3d7-b67fae9139b0');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '0c330132-49ac-4d91-86db-fa123e1a13b9');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'c8cb7446-34b5-490f-ba65-e336fd9a4aca');
INSERT INTO public.composite_role VALUES ('415e0428-bfc4-4e75-aa07-f0c4366b7887', 'd629855a-9d78-4a5e-b3d7-b67fae9139b0');
INSERT INTO public.composite_role VALUES ('6c2bb1cb-6054-436f-877d-0bc799fd9209', '8f99a4e1-a52d-42d6-9147-3873d52b6f11');
INSERT INTO public.composite_role VALUES ('6c2bb1cb-6054-436f-877d-0bc799fd9209', 'c8cb7446-34b5-490f-ba65-e336fd9a4aca');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '766cf210-5fe8-417a-afdf-bfc296e800de');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', 'ac974970-e196-4caf-8024-58bf4ac286e6');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '8cfef5f6-ddda-4f13-bad8-e10216fcf515');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', 'fd77b15c-ea33-4136-b149-4984a69ac31c');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '88673f9f-be6d-489d-a97c-e4ab007e7769');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '82c67e61-7fa9-4d97-ad5d-5d16e29de78d');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '3eefeddc-0db2-429c-8ed7-f47244750748');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', 'c498e06f-ccf8-409f-81cf-368f0dde5838');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '9abb6ee3-3ae0-4c4b-a944-f67bdbb6d48b');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '225899a4-bb69-42fa-8958-126769ea5e54');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '11239de2-3ab4-4b02-aae2-e95ad0f65cc9');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '193e9848-5ea8-4ae5-97f9-c6cc2a18b9af');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', 'fea842ae-ca85-435f-9ac3-dea794b7fccf');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '5eea8c96-7d1f-4073-b55e-fb55730b9968');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '788b9aca-da41-4da7-90e7-cb146c1326bf');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', 'a08739ea-dd09-4a4e-8b22-dc2c6a665cc8');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '1dca4919-7974-4913-8626-0b3e54de3e4c');
INSERT INTO public.composite_role VALUES ('6add7a1a-7987-4b31-b024-377dcc7e1c96', '62252e12-61ed-4b23-9b31-a7213c092908');
INSERT INTO public.composite_role VALUES ('8cfef5f6-ddda-4f13-bad8-e10216fcf515', '5eea8c96-7d1f-4073-b55e-fb55730b9968');
INSERT INTO public.composite_role VALUES ('8cfef5f6-ddda-4f13-bad8-e10216fcf515', '1dca4919-7974-4913-8626-0b3e54de3e4c');
INSERT INTO public.composite_role VALUES ('fd77b15c-ea33-4136-b149-4984a69ac31c', '788b9aca-da41-4da7-90e7-cb146c1326bf');
INSERT INTO public.composite_role VALUES ('6add7a1a-7987-4b31-b024-377dcc7e1c96', '7a31ecb6-4982-4098-af58-0a4feeb4e17e');
INSERT INTO public.composite_role VALUES ('7a31ecb6-4982-4098-af58-0a4feeb4e17e', '16ee476c-06d2-41ad-b771-4752fad677eb');
INSERT INTO public.composite_role VALUES ('4e9d37f0-922a-4f86-a2c6-adeae0aae1a5', '42e146a9-6eb8-4565-ad09-4a4182d570d5');
INSERT INTO public.composite_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', '27c4aa89-6610-427d-891e-635ad9e79cb5');
INSERT INTO public.composite_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '4a10eff9-8f17-410c-81d1-9393c2d4ab09');
INSERT INTO public.composite_role VALUES ('6add7a1a-7987-4b31-b024-377dcc7e1c96', 'f0883d03-7354-4592-b8a3-8d6f52e44e67');
INSERT INTO public.composite_role VALUES ('6add7a1a-7987-4b31-b024-377dcc7e1c96', '71b6b481-a6e1-4581-b507-524d45f585dd');


--
-- TOC entry 4192 (class 0 OID 16420)
-- Dependencies: 213
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.credential VALUES ('eea7e797-9f9f-47be-825f-fdb76cb2b72a', NULL, 'password', 'aafd57d6-7a32-4fd4-9829-c3bcc3ca2fd4', 1754149458647, NULL, '{"value":"uAUuHhWokJyAqrUtcKwX8O0+LoDtthX4pBX9+ReDzdM=","salt":"GuW/CJcTMJe17z9NkD8zxQ==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10, 0);
INSERT INTO public.credential VALUES ('eff1eb40-3e2a-4f6f-ae0a-cca1d1903bb8', NULL, 'password', 'a1df2af0-061e-4157-8636-63a9790a0615', 1754246732763, 'My password', '{"value":"1pPrMlT6BuByNW8pW6BnC8l8s9Q5MRhkiku19Q5fslc=","salt":"vHwwox88hOhpD1H1W7H0oQ==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10, 1);


--
-- TOC entry 4189 (class 0 OID 16390)
-- Dependencies: 210
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2025-08-02 15:44:03.597065', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2025-08-02 15:44:03.636255', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2025-08-02 15:44:03.756759', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2025-08-02 15:44:03.762963', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2025-08-02 15:44:03.983803', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2025-08-02 15:44:03.99949', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2025-08-02 15:44:04.203396', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2025-08-02 15:44:04.210763', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2025-08-02 15:44:04.221338', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2025-08-02 15:44:04.44289', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2025-08-02 15:44:04.550834', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2025-08-02 15:44:04.55713', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2025-08-02 15:44:04.60037', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-08-02 15:44:04.638256', 14, 'EXECUTED', '9:6005e15e84714cd83226bf7879f54190', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-08-02 15:44:04.640409', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-08-02 15:44:04.642819', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-08-02 15:44:04.645432', 17, 'EXECUTED', '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2025-08-02 15:44:04.745885', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2025-08-02 15:44:04.888657', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2025-08-02 15:44:04.896009', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-08-02 15:44:04.900101', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-08-02 15:44:04.905059', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2025-08-02 15:44:05.066717', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2025-08-02 15:44:05.076078', 24, 'EXECUTED', '9:c9999da42f543575ab790e76439a2679', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2025-08-02 15:44:05.078767', 25, 'MARK_RAN', '9:0d6c65c6f58732d81569e77b10ba301d', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2025-08-02 15:44:05.718429', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2025-08-02 15:44:05.940571', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2025-08-02 15:44:05.949312', 28, 'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2025-08-02 15:44:06.115838', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2025-08-02 15:44:06.134448', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2025-08-02 15:44:06.166599', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2025-08-02 15:44:06.17342', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-02 15:44:06.182248', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-02 15:44:06.185631', 34, 'MARK_RAN', '9:f9753208029f582525ed12011a19d054', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-02 15:44:06.238678', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-02 15:44:06.248741', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-08-02 15:44:06.260426', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2025-08-02 15:44:06.269791', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2025-08-02 15:44:06.278498', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-08-02 15:44:06.281519', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-08-02 15:44:06.285871', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2025-08-02 15:44:06.296015', 42, 'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-08-02 15:44:09.3112', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2025-08-02 15:44:09.324749', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-02 15:44:09.337658', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-02 15:44:09.350706', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-02 15:44:09.363042', 47, 'MARK_RAN', '9:51abbacd7b416c50c4421a8cabf7927e', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-02 15:44:09.704281', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-08-02 15:44:09.716002', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2025-08-02 15:44:09.831305', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2025-08-02 15:44:10.660827', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2025-08-02 15:44:10.669979', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2025-08-02 15:44:10.678591', 53, 'EXECUTED', '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2025-08-02 15:44:10.685965', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-08-02 15:44:10.714841', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-08-02 15:44:10.729185', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-08-02 15:44:10.866974', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-08-02 15:44:11.834413', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2025-08-02 15:44:11.896723', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2025-08-02 15:44:11.90822', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2025-08-02 15:44:11.927521', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2025-08-02 15:44:11.939284', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2025-08-02 15:44:11.947119', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2025-08-02 15:44:11.953137', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-08-02 15:44:11.959971', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2025-08-02 15:44:12.066293', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-08-02 15:44:12.147051', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2025-08-02 15:44:12.158795', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2025-08-02 15:44:12.248095', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2025-08-02 15:44:12.258864', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2025-08-02 15:44:12.268101', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-02 15:44:12.285781', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-02 15:44:12.302131', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-02 15:44:12.306485', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-02 15:44:12.362415', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-08-02 15:44:12.415087', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-08-02 15:44:12.420462', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-08-02 15:44:12.422381', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-08-02 15:44:12.449463', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-08-02 15:44:12.452948', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-02 15:44:12.52812', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-02 15:44:12.531295', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-02 15:44:12.540767', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-02 15:44:12.54415', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-08-02 15:44:12.627003', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2025-08-02 15:44:12.638901', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2025-08-02 15:44:12.667998', 87, 'EXECUTED', '9:a9ba7d47f065f041b7da856a81762021', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2025-08-02 15:44:12.689335', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-02 15:44:12.705577', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-02 15:44:12.728734', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-02 15:44:12.824889', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-02 15:44:12.838827', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-02 15:44:12.841367', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-02 15:44:12.855436', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-02 15:44:12.857836', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-08-02 15:44:12.865439', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-02 15:44:13.014731', 97, 'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-02 15:44:13.016665', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-02 15:44:13.032177', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-02 15:44:13.115676', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-02 15:44:13.118028', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-02 15:44:13.170906', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-08-02 15:44:13.176431', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2025-08-02 15:44:13.184785', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2025-08-02 15:44:13.240362', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2025-08-02 15:44:13.294637', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('18.0.15-30992-index-consent', 'keycloak', 'META-INF/jpa-changelog-18.0.15.xml', '2025-08-02 15:44:13.366562', 107, 'EXECUTED', '9:80071ede7a05604b1f4906f3bf3b00f0', 'createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2025-08-02 15:44:13.373623', 108, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-08-02 15:44:13.425071', 109, 'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-08-02 15:44:13.427784', 110, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-08-02 15:44:13.440494', 111, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2025-08-02 15:44:13.446593', 112, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-08-02 15:44:13.477015', 113, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-08-02 15:44:13.479855', 114, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('22.0.0-17484-updated', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-08-02 15:44:13.490157', 115, 'EXECUTED', '9:90af0bfd30cafc17b9f4d6eccd92b8b3', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('22.0.5-24031', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-08-02 15:44:13.493048', 116, 'MARK_RAN', '9:a60d2d7b315ec2d3eba9e2f145f9df28', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('23.0.0-12062', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-08-02 15:44:13.504403', 117, 'EXECUTED', '9:2168fbe728fec46ae9baf15bf80927b8', 'addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('23.0.0-17258', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-08-02 15:44:13.509868', 118, 'EXECUTED', '9:36506d679a83bbfda85a27ea1864dca8', 'addColumn tableName=EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('24.0.0-9758', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-08-02 15:44:13.801629', 119, 'EXECUTED', '9:502c557a5189f600f0f445a9b49ebbce', 'addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('24.0.0-9758-2', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-08-02 15:44:13.811068', 120, 'EXECUTED', '9:bf0fdee10afdf597a987adbf291db7b2', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('24.0.0-26618-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-08-02 15:44:13.823808', 121, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('24.0.0-26618-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-08-02 15:44:13.916361', 122, 'EXECUTED', '9:08707c0f0db1cef6b352db03a60edc7f', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27228', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-08-02 15:44:13.920619', 123, 'EXECUTED', '9:eaee11f6b8aa25d2cc6a84fb86fc6238', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27967-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-08-02 15:44:13.922386', 124, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('24.0.2-27967-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-08-02 15:44:13.925095', 125, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-tables', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:13.936893', 126, 'EXECUTED', '9:deda2df035df23388af95bbd36c17cef', 'addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.00906', 127, 'EXECUTED', '9:3e96709818458ae49f3c679ae58d263a', 'createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-createdon', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.211489', 128, 'EXECUTED', '9:78ab4fc129ed5e8265dbcc3485fba92f', 'dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-preload', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.366521', 129, 'EXECUTED', '9:de5f7c1f7e10994ed8b62e621d20eaab', 'dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-uss-by-usersess', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.51219', 130, 'EXECUTED', '9:6eee220d024e38e89c799417ec33667f', 'dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-cleanup-css-preload', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.650394', 131, 'EXECUTED', '9:5411d2fb2891d3e8d63ddb55dfa3c0c9', 'dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-2-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.653075', 132, 'MARK_RAN', '9:b7ef76036d3126bb83c2423bf4d449d6', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28265-index-2-not-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.724', 133, 'EXECUTED', '9:23396cf51ab8bc1ae6f0cac7f9f6fcf7', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-org', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.750301', 134, 'EXECUTED', '9:5c859965c2c9b9c72136c360649af157', 'createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('unique-consentuser', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.768841', 135, 'EXECUTED', '9:5857626a2ea8767e9a6c66bf3a2cb32f', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('unique-consentuser-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.770816', 136, 'MARK_RAN', '9:b79478aad5adaa1bc428e31563f55e8e', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('25.0.0-28861-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-08-02 15:44:14.875034', 137, 'EXECUTED', '9:b9acb58ac958d9ada0fe12a5d4794ab1', 'createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-alias', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:14.891135', 138, 'EXECUTED', '9:6ef7d63e4412b3c2d66ed179159886a4', 'addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-group', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:14.906245', 139, 'EXECUTED', '9:da8e8087d80ef2ace4f89d8c5b9ca223', 'addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-indexes', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:14.99649', 140, 'EXECUTED', '9:79b05dcd610a8c7f25ec05135eec0857', 'createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.0.0-org-group-membership', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:15.007656', 141, 'EXECUTED', '9:a6ace2ce583a421d89b01ba2a28dc2d4', 'addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('31296-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:15.029084', 142, 'EXECUTED', '9:64ef94489d42a358e8304b0e245f0ed4', 'createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('31725-index-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:15.1099', 143, 'EXECUTED', '9:b994246ec2bf7c94da881e1d28782c7b', 'createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.0.0-idps-for-login', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:15.267036', 144, 'EXECUTED', '9:51f5fffadf986983d4bd59582c6c1604', 'addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.0.0-32583-drop-redundant-index-on-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:15.393328', 145, 'EXECUTED', '9:24972d83bf27317a055d234187bb4af9', 'dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:15.411449', 146, 'EXECUTED', '9:febdc0f47f2ed241c59e60f58c3ceea5', 'dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.0.0-33201-org-redirect-url', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2025-08-02 15:44:15.415806', 147, 'EXECUTED', '9:4d0e22b0ac68ebe9794fa9cb752ea660', 'addColumn tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('29399-jdbc-ping-default', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-08-02 15:44:15.428526', 148, 'EXECUTED', '9:007dbe99d7203fca403b89d4edfdf21e', 'createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.1.0-34013', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-08-02 15:44:15.437093', 149, 'EXECUTED', '9:e6b686a15759aef99a6d758a5c4c6a26', 'addColumn tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.1.0-34380', 'keycloak', 'META-INF/jpa-changelog-26.1.0.xml', '2025-08-02 15:44:15.446401', 150, 'EXECUTED', '9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01', 'dropTable tableName=USERNAME_LOGIN_FAILURE', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.2.0-36750', 'keycloak', 'META-INF/jpa-changelog-26.2.0.xml', '2025-08-02 15:44:15.464793', 151, 'EXECUTED', '9:b49ce951c22f7eb16480ff085640a33a', 'createTable tableName=SERVER_CONFIG', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.2.0-26106', 'keycloak', 'META-INF/jpa-changelog-26.2.0.xml', '2025-08-02 15:44:15.478279', 152, 'EXECUTED', '9:b5877d5dab7d10ff3a9d209d7beb6680', 'addColumn tableName=CREDENTIAL', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.2.6-39866-duplicate', 'keycloak', 'META-INF/jpa-changelog-26.2.6.xml', '2025-08-02 15:44:15.487433', 153, 'EXECUTED', '9:1dc67ccee24f30331db2cba4f372e40e', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.2.6-39866-uk', 'keycloak', 'META-INF/jpa-changelog-26.2.6.xml', '2025-08-02 15:44:15.498198', 154, 'EXECUTED', '9:b70b76f47210cf0a5f4ef0e219eac7cd', 'addUniqueConstraint constraintName=UK_MIGRATION_VERSION, tableName=MIGRATION_MODEL', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.2.6-40088-duplicate', 'keycloak', 'META-INF/jpa-changelog-26.2.6.xml', '2025-08-02 15:44:15.50699', 155, 'EXECUTED', '9:cc7e02ed69ab31979afb1982f9670e8f', 'customChange', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.2.6-40088-uk', 'keycloak', 'META-INF/jpa-changelog-26.2.6.xml', '2025-08-02 15:44:15.517627', 156, 'EXECUTED', '9:5bb848128da7bc4595cc507383325241', 'addUniqueConstraint constraintName=UK_MIGRATION_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.29.1', NULL, NULL, '4149442904');
INSERT INTO public.databasechangelog VALUES ('26.3.0-groups-description', 'keycloak', 'META-INF/jpa-changelog-26.3.0.xml', '2025-08-02 15:44:15.529261', 157, 'EXECUTED', '9:e1a3c05574326fb5b246b73b9a4c4d49', 'addColumn tableName=KEYCLOAK_GROUP', '', NULL, '4.29.1', NULL, NULL, '4149442904');


--
-- TOC entry 4188 (class 0 OID 16385)
-- Dependencies: 209
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.databasechangeloglock VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock VALUES (1000, false, NULL, NULL);


--
-- TOC entry 4263 (class 0 OID 17781)
-- Dependencies: 284
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', '030c326e-b624-4f7f-8735-779e4ef5733c', false);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', '061110cc-5726-47c8-9803-dd277e4aabec', true);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', 'eccb4615-bb99-4b28-8af8-1016382093d4', true);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', 'c6308cac-c900-472e-a60f-76336a232dfd', true);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', '636624a3-b62d-416d-8db1-61554f390979', true);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', 'd5097cb9-e315-48cb-ae0d-c3f825216ae1', false);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', '8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37', false);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', 'ec75baec-3f28-4316-a77b-270b14aaebcb', true);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', 'e97bffb3-edcd-4cce-a59f-32226a722aa8', true);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', '4aaf5956-dbfa-448f-a54b-b013cea9449a', false);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', '04514393-724d-4c68-a20a-322ba0e46344', true);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', '922c2c89-57b2-49a4-abff-11db6e2fb952', true);
INSERT INTO public.default_client_scope VALUES ('da831425-93a2-4023-b385-9915e55fffcf', '2bf591c3-1a81-45c1-a79f-3a15d908ab43', false);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', '3196be8c-060c-48f3-acf7-e2114a5d0f17', false);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', '704448ae-f988-4169-b13e-ab93ac0ea3f8', true);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', 'b6049d9d-efe2-4124-86dc-e87cf6ba4be8', true);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', '334b3943-1d2f-437b-804e-17e81664d2d6', true);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f', true);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', 'ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12', false);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', '51d9887b-6ccb-4474-bd51-7ee28b53dfef', false);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', '87b55b00-2895-4c6f-b55e-d724a97f3c2e', true);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', '768a4ef6-c078-448b-a7bf-8eab89b0d4d6', true);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d', false);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', '6b9e8638-69ce-4b28-99e2-7d87f5f78da6', true);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352', true);
INSERT INTO public.default_client_scope VALUES ('0eb506ab-27da-48e4-8527-269495758e81', 'a6926d37-9345-4ced-baa7-de2a208f9e50', false);


--
-- TOC entry 4193 (class 0 OID 16425)
-- Dependencies: 214
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4251 (class 0 OID 17480)
-- Dependencies: 272
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4252 (class 0 OID 17485)
-- Dependencies: 273
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4265 (class 0 OID 17807)
-- Dependencies: 286
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4253 (class 0 OID 17494)
-- Dependencies: 274
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4254 (class 0 OID 17503)
-- Dependencies: 275
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4255 (class 0 OID 17506)
-- Dependencies: 276
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4256 (class 0 OID 17512)
-- Dependencies: 277
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4213 (class 0 OID 16802)
-- Dependencies: 234
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4259 (class 0 OID 17577)
-- Dependencies: 280
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4235 (class 0 OID 17204)
-- Dependencies: 256
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4234 (class 0 OID 17201)
-- Dependencies: 255
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4214 (class 0 OID 16807)
-- Dependencies: 235
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4215 (class 0 OID 16816)
-- Dependencies: 236
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4219 (class 0 OID 16920)
-- Dependencies: 240
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4220 (class 0 OID 16925)
-- Dependencies: 241
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4274 (class 0 OID 18006)
-- Dependencies: 295
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.jgroups_ping VALUES ('uuid://893693be-743a-4425-9c2e-a862c6d9a573', 'c56b5078f754-24347', 'ISPN', '172.18.0.3:7800', true);


--
-- TOC entry 4233 (class 0 OID 17198)
-- Dependencies: 254
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4194 (class 0 OID 16433)
-- Dependencies: 215
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.keycloak_role VALUES ('772815db-2336-467c-82d0-bd71fd6f46c7', 'da831425-93a2-4023-b385-9915e55fffcf', false, '${role_default-roles}', 'default-roles-master', 'da831425-93a2-4023-b385-9915e55fffcf', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('0d33ee45-557e-48b9-bf69-e95438d0b825', 'da831425-93a2-4023-b385-9915e55fffcf', false, '${role_create-realm}', 'create-realm', 'da831425-93a2-4023-b385-9915e55fffcf', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'da831425-93a2-4023-b385-9915e55fffcf', false, '${role_admin}', 'admin', 'da831425-93a2-4023-b385-9915e55fffcf', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('f24d71da-acb2-4fd9-af3f-1e00f89d9eee', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_create-client}', 'create-client', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('82a0f02d-f761-4563-95c3-8e7f62c23c7b', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_view-realm}', 'view-realm', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('e6c7a4ff-5a36-4571-b1e5-d7d0bce00875', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_view-users}', 'view-users', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('2e71223f-1606-46d2-b506-7559d200fed1', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_view-clients}', 'view-clients', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('634db07f-8e13-45ab-a446-56ea82319f5d', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_view-events}', 'view-events', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('d09c3f62-6b82-40e3-ad85-3ba789a0eb70', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_view-identity-providers}', 'view-identity-providers', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('fb09697b-9cb4-46f0-be5e-60fbbf446a2d', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_view-authorization}', 'view-authorization', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('19f8095a-1865-4a12-be15-8fdafdf75a4a', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_manage-realm}', 'manage-realm', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('9a958e9c-12ed-45d3-9d49-72ae681d6c9d', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_manage-users}', 'manage-users', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('c0e66f0d-c1cd-4e00-9e6b-f2968b95af44', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_manage-clients}', 'manage-clients', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('fa28186a-95ba-4ad0-87a4-41907b869fca', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_manage-events}', 'manage-events', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('1335ad1e-d6c3-449c-b0a2-c1a9cec00825', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('52ed5f56-9e37-428a-a691-dc2cc653517a', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_manage-authorization}', 'manage-authorization', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('86f37236-6c6c-493c-b239-2c8880a8cdc6', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_query-users}', 'query-users', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('26764f1e-4cd6-49a4-8ca4-80c5308e1224', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_query-clients}', 'query-clients', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('8b033e0a-e577-4d50-aa25-34cab36dcb62', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_query-realms}', 'query-realms', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('0006c184-0d08-422f-a823-3a75fb2a9e36', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_query-groups}', 'query-groups', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('11d3da0e-4d82-4d82-b1c2-6747cf3cc8c8', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', true, '${role_view-profile}', 'view-profile', 'da831425-93a2-4023-b385-9915e55fffcf', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', NULL);
INSERT INTO public.keycloak_role VALUES ('a132590a-4e6c-44bd-ac4a-16132c79f965', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', true, '${role_manage-account}', 'manage-account', 'da831425-93a2-4023-b385-9915e55fffcf', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', NULL);
INSERT INTO public.keycloak_role VALUES ('36b7c8e6-1793-45ae-b77a-02b273b11fd1', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', true, '${role_manage-account-links}', 'manage-account-links', 'da831425-93a2-4023-b385-9915e55fffcf', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', NULL);
INSERT INTO public.keycloak_role VALUES ('38d69559-ae33-4a6f-95d1-d7a72b2f8410', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', true, '${role_view-applications}', 'view-applications', 'da831425-93a2-4023-b385-9915e55fffcf', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', NULL);
INSERT INTO public.keycloak_role VALUES ('32859c4c-c5ba-46e5-8e82-4d6b1d5b9c8f', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', true, '${role_view-consent}', 'view-consent', 'da831425-93a2-4023-b385-9915e55fffcf', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', NULL);
INSERT INTO public.keycloak_role VALUES ('68182c8d-de6f-4336-9b50-225e76e14059', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', true, '${role_manage-consent}', 'manage-consent', 'da831425-93a2-4023-b385-9915e55fffcf', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', NULL);
INSERT INTO public.keycloak_role VALUES ('5e842e9a-3e5e-4a09-8ccd-33b2c0196860', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', true, '${role_view-groups}', 'view-groups', 'da831425-93a2-4023-b385-9915e55fffcf', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', NULL);
INSERT INTO public.keycloak_role VALUES ('49287398-c743-453c-a11b-51c16fe4c8e2', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', true, '${role_delete-account}', 'delete-account', 'da831425-93a2-4023-b385-9915e55fffcf', 'f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', NULL);
INSERT INTO public.keycloak_role VALUES ('4d237884-749f-41e9-a599-4b2256cd337a', '0520d506-78d7-4fd5-8a2c-a0954eecc0ca', true, '${role_read-token}', 'read-token', 'da831425-93a2-4023-b385-9915e55fffcf', '0520d506-78d7-4fd5-8a2c-a0954eecc0ca', NULL);
INSERT INTO public.keycloak_role VALUES ('d621916a-b076-49a0-9620-6e073be054b7', 'c228b077-1433-4c33-b76b-12fe426d2f41', true, '${role_impersonation}', 'impersonation', 'da831425-93a2-4023-b385-9915e55fffcf', 'c228b077-1433-4c33-b76b-12fe426d2f41', NULL);
INSERT INTO public.keycloak_role VALUES ('2a8dfd62-5bcd-4c51-bc38-55331d78273b', 'da831425-93a2-4023-b385-9915e55fffcf', false, '${role_offline-access}', 'offline_access', 'da831425-93a2-4023-b385-9915e55fffcf', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('062a3c5b-0d52-4a97-b3d3-e1f9d41cae7e', 'da831425-93a2-4023-b385-9915e55fffcf', false, '${role_uma_authorization}', 'uma_authorization', 'da831425-93a2-4023-b385-9915e55fffcf', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('6add7a1a-7987-4b31-b024-377dcc7e1c96', '0eb506ab-27da-48e4-8527-269495758e81', false, '${role_default-roles}', 'default-roles-redirect-login-example', '0eb506ab-27da-48e4-8527-269495758e81', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('b12b3cba-c56f-4581-980c-4c74c3b14201', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_create-client}', 'create-client', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('1f7cd251-6b82-41e6-85a9-6754bee8b256', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_view-realm}', 'view-realm', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('6c2bb1cb-6054-436f-877d-0bc799fd9209', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_view-users}', 'view-users', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('415e0428-bfc4-4e75-aa07-f0c4366b7887', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_view-clients}', 'view-clients', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('55e4ab6a-ef80-4166-8778-2b622a8608e6', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_view-events}', 'view-events', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('fbd73f91-8ed4-486a-9587-b29d122559ba', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_view-identity-providers}', 'view-identity-providers', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('c9868916-0c70-4cda-b5b2-0fb9b0bd6ffa', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_view-authorization}', 'view-authorization', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('8e086756-61d3-4138-bb3f-fd0ff41c9381', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_manage-realm}', 'manage-realm', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('4d8988bb-2eb2-4772-91ff-a53635fe7f00', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_manage-users}', 'manage-users', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('f8368d8b-e1a4-439c-ae3e-c04a653d1541', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_manage-clients}', 'manage-clients', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('f76fa262-e997-44bc-b4a1-a6745d990306', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_manage-events}', 'manage-events', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('ba9b1193-e683-4f00-9a3f-22ada1af9a87', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('f4490bfa-998b-4ad7-b53f-4fe3d35490a8', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_manage-authorization}', 'manage-authorization', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('8f99a4e1-a52d-42d6-9147-3873d52b6f11', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_query-users}', 'query-users', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('d629855a-9d78-4a5e-b3d7-b67fae9139b0', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_query-clients}', 'query-clients', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('0c330132-49ac-4d91-86db-fa123e1a13b9', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_query-realms}', 'query-realms', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('c8cb7446-34b5-490f-ba65-e336fd9a4aca', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_query-groups}', 'query-groups', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('66ca2410-e326-4d52-a360-4f22074b7d1c', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_realm-admin}', 'realm-admin', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('766cf210-5fe8-417a-afdf-bfc296e800de', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_create-client}', 'create-client', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('ac974970-e196-4caf-8024-58bf4ac286e6', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_view-realm}', 'view-realm', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('8cfef5f6-ddda-4f13-bad8-e10216fcf515', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_view-users}', 'view-users', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('fd77b15c-ea33-4136-b149-4984a69ac31c', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_view-clients}', 'view-clients', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('88673f9f-be6d-489d-a97c-e4ab007e7769', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_view-events}', 'view-events', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('82c67e61-7fa9-4d97-ad5d-5d16e29de78d', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_view-identity-providers}', 'view-identity-providers', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('3eefeddc-0db2-429c-8ed7-f47244750748', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_view-authorization}', 'view-authorization', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('c498e06f-ccf8-409f-81cf-368f0dde5838', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_manage-realm}', 'manage-realm', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('9abb6ee3-3ae0-4c4b-a944-f67bdbb6d48b', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_manage-users}', 'manage-users', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('225899a4-bb69-42fa-8958-126769ea5e54', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_manage-clients}', 'manage-clients', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('11239de2-3ab4-4b02-aae2-e95ad0f65cc9', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_manage-events}', 'manage-events', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('193e9848-5ea8-4ae5-97f9-c6cc2a18b9af', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_manage-identity-providers}', 'manage-identity-providers', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('fea842ae-ca85-435f-9ac3-dea794b7fccf', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_manage-authorization}', 'manage-authorization', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('5eea8c96-7d1f-4073-b55e-fb55730b9968', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_query-users}', 'query-users', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('788b9aca-da41-4da7-90e7-cb146c1326bf', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_query-clients}', 'query-clients', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('a08739ea-dd09-4a4e-8b22-dc2c6a665cc8', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_query-realms}', 'query-realms', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('1dca4919-7974-4913-8626-0b3e54de3e4c', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_query-groups}', 'query-groups', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('62252e12-61ed-4b23-9b31-a7213c092908', '0c88be54-b950-4727-9f30-a2fa8e0775be', true, '${role_view-profile}', 'view-profile', '0eb506ab-27da-48e4-8527-269495758e81', '0c88be54-b950-4727-9f30-a2fa8e0775be', NULL);
INSERT INTO public.keycloak_role VALUES ('7a31ecb6-4982-4098-af58-0a4feeb4e17e', '0c88be54-b950-4727-9f30-a2fa8e0775be', true, '${role_manage-account}', 'manage-account', '0eb506ab-27da-48e4-8527-269495758e81', '0c88be54-b950-4727-9f30-a2fa8e0775be', NULL);
INSERT INTO public.keycloak_role VALUES ('16ee476c-06d2-41ad-b771-4752fad677eb', '0c88be54-b950-4727-9f30-a2fa8e0775be', true, '${role_manage-account-links}', 'manage-account-links', '0eb506ab-27da-48e4-8527-269495758e81', '0c88be54-b950-4727-9f30-a2fa8e0775be', NULL);
INSERT INTO public.keycloak_role VALUES ('33732f1f-ca88-4e35-b20f-2a702beb5518', '0c88be54-b950-4727-9f30-a2fa8e0775be', true, '${role_view-applications}', 'view-applications', '0eb506ab-27da-48e4-8527-269495758e81', '0c88be54-b950-4727-9f30-a2fa8e0775be', NULL);
INSERT INTO public.keycloak_role VALUES ('42e146a9-6eb8-4565-ad09-4a4182d570d5', '0c88be54-b950-4727-9f30-a2fa8e0775be', true, '${role_view-consent}', 'view-consent', '0eb506ab-27da-48e4-8527-269495758e81', '0c88be54-b950-4727-9f30-a2fa8e0775be', NULL);
INSERT INTO public.keycloak_role VALUES ('4e9d37f0-922a-4f86-a2c6-adeae0aae1a5', '0c88be54-b950-4727-9f30-a2fa8e0775be', true, '${role_manage-consent}', 'manage-consent', '0eb506ab-27da-48e4-8527-269495758e81', '0c88be54-b950-4727-9f30-a2fa8e0775be', NULL);
INSERT INTO public.keycloak_role VALUES ('77f759c4-f319-40c7-ac74-49ab07885337', '0c88be54-b950-4727-9f30-a2fa8e0775be', true, '${role_view-groups}', 'view-groups', '0eb506ab-27da-48e4-8527-269495758e81', '0c88be54-b950-4727-9f30-a2fa8e0775be', NULL);
INSERT INTO public.keycloak_role VALUES ('5988ce05-7b7d-444c-adec-7cd1b49b9938', '0c88be54-b950-4727-9f30-a2fa8e0775be', true, '${role_delete-account}', 'delete-account', '0eb506ab-27da-48e4-8527-269495758e81', '0c88be54-b950-4727-9f30-a2fa8e0775be', NULL);
INSERT INTO public.keycloak_role VALUES ('27c4aa89-6610-427d-891e-635ad9e79cb5', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', true, '${role_impersonation}', 'impersonation', 'da831425-93a2-4023-b385-9915e55fffcf', 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', NULL);
INSERT INTO public.keycloak_role VALUES ('4a10eff9-8f17-410c-81d1-9393c2d4ab09', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', true, '${role_impersonation}', 'impersonation', '0eb506ab-27da-48e4-8527-269495758e81', '1fa89201-57a9-4c55-8d85-46f85ec5dff3', NULL);
INSERT INTO public.keycloak_role VALUES ('60b3c491-da2a-40a4-833f-10c38b398782', '3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', true, '${role_read-token}', 'read-token', '0eb506ab-27da-48e4-8527-269495758e81', '3e872eb7-d50e-4beb-a79f-7c3ce3438a0d', NULL);
INSERT INTO public.keycloak_role VALUES ('f0883d03-7354-4592-b8a3-8d6f52e44e67', '0eb506ab-27da-48e4-8527-269495758e81', false, '${role_offline-access}', 'offline_access', '0eb506ab-27da-48e4-8527-269495758e81', NULL, NULL);
INSERT INTO public.keycloak_role VALUES ('71b6b481-a6e1-4581-b507-524d45f585dd', '0eb506ab-27da-48e4-8527-269495758e81', false, '${role_uma_authorization}', 'uma_authorization', '0eb506ab-27da-48e4-8527-269495758e81', NULL, NULL);


--
-- TOC entry 4218 (class 0 OID 16917)
-- Dependencies: 239
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.migration_model VALUES ('13pe0', '26.3.2', 1754149457);


--
-- TOC entry 4232 (class 0 OID 17189)
-- Dependencies: 253
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.offline_client_session VALUES ('65ade835-dadd-4901-a7f7-485f3dfd6c95', 'cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '0', 1754250652, '{"authMethod":"openid-connect","redirectUri":"http://localhost:8080/admin/master/console/#/redirect-login-example/users/a1df2af0-061e-4157-8636-63a9790a0615/sessions","notes":{"clientId":"cd96a33a-0b7a-4f48-a2c1-84bfe8596fad","iss":"http://localhost:8080/realms/master","startedAt":"1754244453","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"33c0871b-27a5-40c4-b744-549eedc64fcf","response_mode":"query","scope":"openid","userSessionStartedAt":"1754244453","redirect_uri":"http://localhost:8080/admin/master/console/#/redirect-login-example/users/a1df2af0-061e-4157-8636-63a9790a0615/sessions","state":"91a461ba-6235-4fe3-9cec-11ddc2ba4745","code_challenge":"MMMaI49VEqKySduwgO-cb6dakZ1FE4y4hqpJ5uCDEeI","prompt":"none","SSO_AUTH":"true"}}', 'local', 'local', 21);
INSERT INTO public.offline_client_session VALUES ('9f6eb7ec-ed57-4e1e-95c1-4ac6b7954881', 'a24691f3-e86b-4aae-a732-736c5578a0db', '0', 1754249598, '{"authMethod":"openid-connect","redirectUri":"http://localhost:8083/login/oauth2/code/keycloak","notes":{"clientId":"a24691f3-e86b-4aae-a732-736c5578a0db","scope":"openid profile email","userSessionStartedAt":"1754249572","iss":"http://localhost:8080/realms/redirect-login-example","startedAt":"1754249572","response_type":"code","level-of-authentication":"-1","redirect_uri":"http://localhost:8083/login/oauth2/code/keycloak","state":"zc5XpLhmUw-faH2Oo6Ji_ph1CsoixBqYP7Ds2smlwlQ=","nonce":"G-7GZE1M2xmOdshbRZuj4ym1BOJdP_eDthTVjg3JRmo","SSO_AUTH":"true"}}', 'local', 'local', 1);


--
-- TOC entry 4231 (class 0 OID 17184)
-- Dependencies: 252
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.offline_user_session VALUES ('9f6eb7ec-ed57-4e1e-95c1-4ac6b7954881', 'a1df2af0-061e-4157-8636-63a9790a0615', '0eb506ab-27da-48e4-8527-269495758e81', 1754249572, '0', '{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRWRnZS8xMzguMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1754249572","authenticators-completed":"{\"b8ff3ffe-0190-4d33-869b-bef1fb16fd2b\":1754249572,\"997dcfb5-416b-4423-b164-754d08102952\":1754249598}"},"state":"LOGGED_IN"}', 1754249598, NULL, 1);
INSERT INTO public.offline_user_session VALUES ('65ade835-dadd-4901-a7f7-485f3dfd6c95', 'aafd57d6-7a32-4fd4-9829-c3bcc3ca2fd4', 'da831425-93a2-4023-b385-9915e55fffcf', 1754244453, '0', '{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRWRnZS8xMzguMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1754244453","authenticators-completed":"{\"b600b995-9cb8-46fd-a879-ddc1c012a805\":1754244453,\"0b0d1942-2f06-49ab-88a5-a55aa5e39ccf\":1754247627}"},"state":"LOGGED_IN"}', 1754250652, NULL, 21);


--
-- TOC entry 4271 (class 0 OID 17969)
-- Dependencies: 292
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4272 (class 0 OID 17980)
-- Dependencies: 293
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4245 (class 0 OID 17403)
-- Dependencies: 266
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4211 (class 0 OID 16791)
-- Dependencies: 232
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.protocol_mapper VALUES ('8bfe1502-397e-4a59-a633-854d3f7dd6ae', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', 'a19c468d-3538-42d6-a927-8e4332d92d7e', NULL);
INSERT INTO public.protocol_mapper VALUES ('a1b63e5c-829a-4018-b610-15364f6425e2', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', NULL);
INSERT INTO public.protocol_mapper VALUES ('c2af039f-8e13-4095-b95c-8c1a8533a5f3', 'role list', 'saml', 'saml-role-list-mapper', NULL, '061110cc-5726-47c8-9803-dd277e4aabec');
INSERT INTO public.protocol_mapper VALUES ('426f471c-d61c-41a1-9bab-26d74fcda790', 'organization', 'saml', 'saml-organization-membership-mapper', NULL, 'eccb4615-bb99-4b28-8af8-1016382093d4');
INSERT INTO public.protocol_mapper VALUES ('a2260f77-9446-4f01-8269-7db3b0233aac', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('031f24f2-c0a6-4e65-9269-08efdab20b47', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('98c86379-9344-467e-ab3b-de48df063777', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('331bdf09-b4e7-4878-85a8-ab0a7259c66b', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('3eb114b9-e9fa-47c4-9cb6-556bdea9ef0c', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('67485811-e7dd-4eb0-afea-926472f74b31', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('a45a34a5-8c7e-4d38-b022-87021a488ca0', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('df14f0a2-9478-4340-84d9-3e8bc3834bd0', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('b0518d4c-18c3-454a-8b80-15a3cb36c68f', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('8d7b2e11-c6e4-4eda-a10a-ffc8125dbc92', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('8bd4cc1d-bdfe-4c86-af9a-42c551119531', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('0b755c8b-9253-4af2-a7e6-e40534d4dc45', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('714866f1-08bd-415d-9f69-81b8d33aad5f', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('ea3cd20a-9ade-4c0a-9d29-fbb849e2806b', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6308cac-c900-472e-a60f-76336a232dfd');
INSERT INTO public.protocol_mapper VALUES ('558552e3-74c6-4325-9b8f-97214b77ceec', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '636624a3-b62d-416d-8db1-61554f390979');
INSERT INTO public.protocol_mapper VALUES ('6c85f0f5-8125-4633-b8a9-95483b8f3024', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '636624a3-b62d-416d-8db1-61554f390979');
INSERT INTO public.protocol_mapper VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'd5097cb9-e315-48cb-ae0d-c3f825216ae1');
INSERT INTO public.protocol_mapper VALUES ('d6deb31f-f28b-4624-91d8-bc608630b5bc', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37');
INSERT INTO public.protocol_mapper VALUES ('259682e9-0b76-4aaa-8d7c-60441ab1c224', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '8ad575ef-1031-4bdf-9bb5-eb1b62e3fa37');
INSERT INTO public.protocol_mapper VALUES ('951ada0a-792e-4d09-9571-af0cc190d4c9', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'ec75baec-3f28-4316-a77b-270b14aaebcb');
INSERT INTO public.protocol_mapper VALUES ('17341b53-f6ec-474e-b410-dcbad7488ae5', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'ec75baec-3f28-4316-a77b-270b14aaebcb');
INSERT INTO public.protocol_mapper VALUES ('27ab08fc-63b5-4862-a318-2502b9d78348', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'ec75baec-3f28-4316-a77b-270b14aaebcb');
INSERT INTO public.protocol_mapper VALUES ('d30ba309-991c-4b4e-bbd0-802657779a67', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, 'e97bffb3-edcd-4cce-a59f-32226a722aa8');
INSERT INTO public.protocol_mapper VALUES ('82e7f2bf-033f-43a1-9e98-29b7e6f33fc7', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '4aaf5956-dbfa-448f-a54b-b013cea9449a');
INSERT INTO public.protocol_mapper VALUES ('cb9c30c0-e126-4bf1-89fa-bac258a4bfe9', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '4aaf5956-dbfa-448f-a54b-b013cea9449a');
INSERT INTO public.protocol_mapper VALUES ('d8d6eb70-09d8-440e-b5c1-c7698b243c6a', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, '04514393-724d-4c68-a20a-322ba0e46344');
INSERT INTO public.protocol_mapper VALUES ('dfcaa3ff-cf26-4956-854f-5d63fe15a64c', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '922c2c89-57b2-49a4-abff-11db6e2fb952');
INSERT INTO public.protocol_mapper VALUES ('ca71d791-4de2-437b-94d9-8bb5bb2dbb6a', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL, '922c2c89-57b2-49a4-abff-11db6e2fb952');
INSERT INTO public.protocol_mapper VALUES ('5579c0d5-2b89-4af1-b817-504e708a94af', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'c848eb88-1758-4cfc-95a9-976c68304fb7');
INSERT INTO public.protocol_mapper VALUES ('b8986993-86d2-4c3b-94d7-7512535c6e7c', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'c848eb88-1758-4cfc-95a9-976c68304fb7');
INSERT INTO public.protocol_mapper VALUES ('d95885c5-a6a4-45bf-9fd5-ed0a722eaafd', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'c848eb88-1758-4cfc-95a9-976c68304fb7');
INSERT INTO public.protocol_mapper VALUES ('7f4a71f3-3d5b-43ec-958e-57440f5d480b', 'organization', 'openid-connect', 'oidc-organization-membership-mapper', NULL, '2bf591c3-1a81-45c1-a79f-3a15d908ab43');
INSERT INTO public.protocol_mapper VALUES ('8cb55d84-862a-4544-8b47-5b817ce52736', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', 'f125549a-5d8f-40d8-8637-ca427e477048', NULL);
INSERT INTO public.protocol_mapper VALUES ('b011be5a-cfef-4927-960d-94587743380a', 'role list', 'saml', 'saml-role-list-mapper', NULL, '704448ae-f988-4169-b13e-ab93ac0ea3f8');
INSERT INTO public.protocol_mapper VALUES ('809517bc-c30f-43c4-bdf3-23a6d8ecc773', 'organization', 'saml', 'saml-organization-membership-mapper', NULL, 'b6049d9d-efe2-4124-86dc-e87cf6ba4be8');
INSERT INTO public.protocol_mapper VALUES ('a51ffee9-0752-4e9f-af0f-5cb807cb2d5c', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('921b89f6-d213-4679-9326-2d3473c9e2e8', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('91bf0504-504c-4865-93be-83733af19988', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('7d1d0e6b-4dba-4da0-9259-ca3b09ebeb4a', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('67181fbd-7777-401b-87e3-d8c8cdcfcc07', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('0963e895-2529-4555-8507-3fb75b67682b', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('0ba1e61d-58f6-49c5-8f3a-6324fcc19c37', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('34ca67a8-d789-4ce7-819f-6773f675114c', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('c8f1469b-6338-4519-93b5-616ea036c180', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('bb904067-c001-4cfc-aa17-3cf565d0cc39', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('dd2af4df-54c9-4c52-8e26-897594696c0e', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('3e10e588-adc8-4b34-83d5-4bdcb2363e90', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('5c630df6-977b-44a7-86c8-5e9e400db9f4', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('65c8a40c-18c8-4395-8178-388199ec55ff', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '334b3943-1d2f-437b-804e-17e81664d2d6');
INSERT INTO public.protocol_mapper VALUES ('2732b228-9ded-4619-b817-54dc6493831d', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f');
INSERT INTO public.protocol_mapper VALUES ('c55b5ef0-61fa-4c5a-98f5-a26340635f74', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'ffc79c04-2f92-497b-98e1-5d10e72e0a8f');
INSERT INTO public.protocol_mapper VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'ccf0c6d0-2b57-45e5-a4af-5d15a3e78b12');
INSERT INTO public.protocol_mapper VALUES ('dd307da9-1e95-4b59-a8f7-f567359bedfd', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '51d9887b-6ccb-4474-bd51-7ee28b53dfef');
INSERT INTO public.protocol_mapper VALUES ('267ecdbf-3a4d-4eb0-b812-c6a4045fabe6', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '51d9887b-6ccb-4474-bd51-7ee28b53dfef');
INSERT INTO public.protocol_mapper VALUES ('eca233a1-4f18-4253-86e3-271242c8f803', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '87b55b00-2895-4c6f-b55e-d724a97f3c2e');
INSERT INTO public.protocol_mapper VALUES ('dbc01bea-fd9a-4503-b0b3-689270145bd5', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '87b55b00-2895-4c6f-b55e-d724a97f3c2e');
INSERT INTO public.protocol_mapper VALUES ('29380fa6-e292-40a1-bec1-b9d862035f3a', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '87b55b00-2895-4c6f-b55e-d724a97f3c2e');
INSERT INTO public.protocol_mapper VALUES ('05f7aeeb-ec9e-4a52-b1e0-8f2d0a12b13e', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '768a4ef6-c078-448b-a7bf-8eab89b0d4d6');
INSERT INTO public.protocol_mapper VALUES ('1a2a1ba8-0159-404f-8a1f-d2e7408baddb', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d');
INSERT INTO public.protocol_mapper VALUES ('cb72dc3d-bb77-4011-b3ba-503b14f2f2cd', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'a241aa87-fb91-4ba7-af6c-f9ec1a83a65d');
INSERT INTO public.protocol_mapper VALUES ('03fc53ba-8186-4709-ae94-2a5c6f8168af', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, '6b9e8638-69ce-4b28-99e2-7d87f5f78da6');
INSERT INTO public.protocol_mapper VALUES ('616c7aec-87c6-43f3-ac32-e2411cccb1d3', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352');
INSERT INTO public.protocol_mapper VALUES ('f4501724-1956-4652-b226-2f214c8b62bb', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL, 'a8263a4e-42c0-4b7d-bfcc-eae7d0af8352');
INSERT INTO public.protocol_mapper VALUES ('19cb0719-4df3-4a2e-af51-58870d58c647', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '3a710695-c13d-423d-8163-01f505c8a89e');
INSERT INTO public.protocol_mapper VALUES ('03167df3-c29f-4c7e-8879-72e0d874d39a', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '3a710695-c13d-423d-8163-01f505c8a89e');
INSERT INTO public.protocol_mapper VALUES ('69b6ec4c-ec3b-41ab-9326-e4ce859e3ce8', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, '3a710695-c13d-423d-8163-01f505c8a89e');
INSERT INTO public.protocol_mapper VALUES ('d80023ec-a184-4f1e-8f62-fa152f1e516c', 'organization', 'openid-connect', 'oidc-organization-membership-mapper', NULL, 'a6926d37-9345-4ced-baa7-de2a208f9e50');
INSERT INTO public.protocol_mapper VALUES ('2c132704-5c52-4094-baba-cd0e5ce50983', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '56c66833-c8cd-499b-a921-3ef063da04ed', NULL);


--
-- TOC entry 4212 (class 0 OID 16797)
-- Dependencies: 233
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.protocol_mapper_config VALUES ('a1b63e5c-829a-4018-b610-15364f6425e2', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a1b63e5c-829a-4018-b610-15364f6425e2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a1b63e5c-829a-4018-b610-15364f6425e2', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a1b63e5c-829a-4018-b610-15364f6425e2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a1b63e5c-829a-4018-b610-15364f6425e2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a1b63e5c-829a-4018-b610-15364f6425e2', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a1b63e5c-829a-4018-b610-15364f6425e2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c2af039f-8e13-4095-b95c-8c1a8533a5f3', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('c2af039f-8e13-4095-b95c-8c1a8533a5f3', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('c2af039f-8e13-4095-b95c-8c1a8533a5f3', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('031f24f2-c0a6-4e65-9269-08efdab20b47', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('031f24f2-c0a6-4e65-9269-08efdab20b47', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('031f24f2-c0a6-4e65-9269-08efdab20b47', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('031f24f2-c0a6-4e65-9269-08efdab20b47', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('031f24f2-c0a6-4e65-9269-08efdab20b47', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('031f24f2-c0a6-4e65-9269-08efdab20b47', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('031f24f2-c0a6-4e65-9269-08efdab20b47', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0b755c8b-9253-4af2-a7e6-e40534d4dc45', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0b755c8b-9253-4af2-a7e6-e40534d4dc45', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0b755c8b-9253-4af2-a7e6-e40534d4dc45', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('0b755c8b-9253-4af2-a7e6-e40534d4dc45', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0b755c8b-9253-4af2-a7e6-e40534d4dc45', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0b755c8b-9253-4af2-a7e6-e40534d4dc45', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0b755c8b-9253-4af2-a7e6-e40534d4dc45', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('331bdf09-b4e7-4878-85a8-ab0a7259c66b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('331bdf09-b4e7-4878-85a8-ab0a7259c66b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('331bdf09-b4e7-4878-85a8-ab0a7259c66b', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('331bdf09-b4e7-4878-85a8-ab0a7259c66b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('331bdf09-b4e7-4878-85a8-ab0a7259c66b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('331bdf09-b4e7-4878-85a8-ab0a7259c66b', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('331bdf09-b4e7-4878-85a8-ab0a7259c66b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3eb114b9-e9fa-47c4-9cb6-556bdea9ef0c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3eb114b9-e9fa-47c4-9cb6-556bdea9ef0c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3eb114b9-e9fa-47c4-9cb6-556bdea9ef0c', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3eb114b9-e9fa-47c4-9cb6-556bdea9ef0c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3eb114b9-e9fa-47c4-9cb6-556bdea9ef0c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3eb114b9-e9fa-47c4-9cb6-556bdea9ef0c', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3eb114b9-e9fa-47c4-9cb6-556bdea9ef0c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('67485811-e7dd-4eb0-afea-926472f74b31', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('67485811-e7dd-4eb0-afea-926472f74b31', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('67485811-e7dd-4eb0-afea-926472f74b31', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('67485811-e7dd-4eb0-afea-926472f74b31', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('67485811-e7dd-4eb0-afea-926472f74b31', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('67485811-e7dd-4eb0-afea-926472f74b31', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('67485811-e7dd-4eb0-afea-926472f74b31', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('714866f1-08bd-415d-9f69-81b8d33aad5f', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('714866f1-08bd-415d-9f69-81b8d33aad5f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('714866f1-08bd-415d-9f69-81b8d33aad5f', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('714866f1-08bd-415d-9f69-81b8d33aad5f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('714866f1-08bd-415d-9f69-81b8d33aad5f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('714866f1-08bd-415d-9f69-81b8d33aad5f', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('714866f1-08bd-415d-9f69-81b8d33aad5f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('8bd4cc1d-bdfe-4c86-af9a-42c551119531', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8bd4cc1d-bdfe-4c86-af9a-42c551119531', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8bd4cc1d-bdfe-4c86-af9a-42c551119531', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('8bd4cc1d-bdfe-4c86-af9a-42c551119531', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8bd4cc1d-bdfe-4c86-af9a-42c551119531', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8bd4cc1d-bdfe-4c86-af9a-42c551119531', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('8bd4cc1d-bdfe-4c86-af9a-42c551119531', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('8d7b2e11-c6e4-4eda-a10a-ffc8125dbc92', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8d7b2e11-c6e4-4eda-a10a-ffc8125dbc92', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8d7b2e11-c6e4-4eda-a10a-ffc8125dbc92', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('8d7b2e11-c6e4-4eda-a10a-ffc8125dbc92', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8d7b2e11-c6e4-4eda-a10a-ffc8125dbc92', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('8d7b2e11-c6e4-4eda-a10a-ffc8125dbc92', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('8d7b2e11-c6e4-4eda-a10a-ffc8125dbc92', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('98c86379-9344-467e-ab3b-de48df063777', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('98c86379-9344-467e-ab3b-de48df063777', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('98c86379-9344-467e-ab3b-de48df063777', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('98c86379-9344-467e-ab3b-de48df063777', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('98c86379-9344-467e-ab3b-de48df063777', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('98c86379-9344-467e-ab3b-de48df063777', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('98c86379-9344-467e-ab3b-de48df063777', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a2260f77-9446-4f01-8269-7db3b0233aac', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a2260f77-9446-4f01-8269-7db3b0233aac', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a2260f77-9446-4f01-8269-7db3b0233aac', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a2260f77-9446-4f01-8269-7db3b0233aac', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a45a34a5-8c7e-4d38-b022-87021a488ca0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a45a34a5-8c7e-4d38-b022-87021a488ca0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a45a34a5-8c7e-4d38-b022-87021a488ca0', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('a45a34a5-8c7e-4d38-b022-87021a488ca0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a45a34a5-8c7e-4d38-b022-87021a488ca0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a45a34a5-8c7e-4d38-b022-87021a488ca0', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('a45a34a5-8c7e-4d38-b022-87021a488ca0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('b0518d4c-18c3-454a-8b80-15a3cb36c68f', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b0518d4c-18c3-454a-8b80-15a3cb36c68f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b0518d4c-18c3-454a-8b80-15a3cb36c68f', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('b0518d4c-18c3-454a-8b80-15a3cb36c68f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b0518d4c-18c3-454a-8b80-15a3cb36c68f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b0518d4c-18c3-454a-8b80-15a3cb36c68f', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('b0518d4c-18c3-454a-8b80-15a3cb36c68f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('df14f0a2-9478-4340-84d9-3e8bc3834bd0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('df14f0a2-9478-4340-84d9-3e8bc3834bd0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('df14f0a2-9478-4340-84d9-3e8bc3834bd0', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('df14f0a2-9478-4340-84d9-3e8bc3834bd0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('df14f0a2-9478-4340-84d9-3e8bc3834bd0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('df14f0a2-9478-4340-84d9-3e8bc3834bd0', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('df14f0a2-9478-4340-84d9-3e8bc3834bd0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('ea3cd20a-9ade-4c0a-9d29-fbb849e2806b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ea3cd20a-9ade-4c0a-9d29-fbb849e2806b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ea3cd20a-9ade-4c0a-9d29-fbb849e2806b', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('ea3cd20a-9ade-4c0a-9d29-fbb849e2806b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ea3cd20a-9ade-4c0a-9d29-fbb849e2806b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ea3cd20a-9ade-4c0a-9d29-fbb849e2806b', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('ea3cd20a-9ade-4c0a-9d29-fbb849e2806b', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('558552e3-74c6-4325-9b8f-97214b77ceec', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('558552e3-74c6-4325-9b8f-97214b77ceec', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('558552e3-74c6-4325-9b8f-97214b77ceec', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('558552e3-74c6-4325-9b8f-97214b77ceec', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('558552e3-74c6-4325-9b8f-97214b77ceec', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('558552e3-74c6-4325-9b8f-97214b77ceec', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('558552e3-74c6-4325-9b8f-97214b77ceec', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('6c85f0f5-8125-4633-b8a9-95483b8f3024', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6c85f0f5-8125-4633-b8a9-95483b8f3024', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6c85f0f5-8125-4633-b8a9-95483b8f3024', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('6c85f0f5-8125-4633-b8a9-95483b8f3024', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6c85f0f5-8125-4633-b8a9-95483b8f3024', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('6c85f0f5-8125-4633-b8a9-95483b8f3024', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('6c85f0f5-8125-4633-b8a9-95483b8f3024', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('fcbe818a-82f6-40af-906c-609dc0c9e45c', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('259682e9-0b76-4aaa-8d7c-60441ab1c224', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('259682e9-0b76-4aaa-8d7c-60441ab1c224', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('259682e9-0b76-4aaa-8d7c-60441ab1c224', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('259682e9-0b76-4aaa-8d7c-60441ab1c224', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('259682e9-0b76-4aaa-8d7c-60441ab1c224', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('259682e9-0b76-4aaa-8d7c-60441ab1c224', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('259682e9-0b76-4aaa-8d7c-60441ab1c224', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d6deb31f-f28b-4624-91d8-bc608630b5bc', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6deb31f-f28b-4624-91d8-bc608630b5bc', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6deb31f-f28b-4624-91d8-bc608630b5bc', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('d6deb31f-f28b-4624-91d8-bc608630b5bc', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6deb31f-f28b-4624-91d8-bc608630b5bc', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d6deb31f-f28b-4624-91d8-bc608630b5bc', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d6deb31f-f28b-4624-91d8-bc608630b5bc', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('17341b53-f6ec-474e-b410-dcbad7488ae5', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('17341b53-f6ec-474e-b410-dcbad7488ae5', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('17341b53-f6ec-474e-b410-dcbad7488ae5', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('17341b53-f6ec-474e-b410-dcbad7488ae5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('17341b53-f6ec-474e-b410-dcbad7488ae5', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('17341b53-f6ec-474e-b410-dcbad7488ae5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('27ab08fc-63b5-4862-a318-2502b9d78348', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('27ab08fc-63b5-4862-a318-2502b9d78348', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('951ada0a-792e-4d09-9571-af0cc190d4c9', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('951ada0a-792e-4d09-9571-af0cc190d4c9', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('951ada0a-792e-4d09-9571-af0cc190d4c9', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('951ada0a-792e-4d09-9571-af0cc190d4c9', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('951ada0a-792e-4d09-9571-af0cc190d4c9', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('951ada0a-792e-4d09-9571-af0cc190d4c9', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d30ba309-991c-4b4e-bbd0-802657779a67', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d30ba309-991c-4b4e-bbd0-802657779a67', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('82e7f2bf-033f-43a1-9e98-29b7e6f33fc7', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('82e7f2bf-033f-43a1-9e98-29b7e6f33fc7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('82e7f2bf-033f-43a1-9e98-29b7e6f33fc7', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('82e7f2bf-033f-43a1-9e98-29b7e6f33fc7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('82e7f2bf-033f-43a1-9e98-29b7e6f33fc7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('82e7f2bf-033f-43a1-9e98-29b7e6f33fc7', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('82e7f2bf-033f-43a1-9e98-29b7e6f33fc7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('cb9c30c0-e126-4bf1-89fa-bac258a4bfe9', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb9c30c0-e126-4bf1-89fa-bac258a4bfe9', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('cb9c30c0-e126-4bf1-89fa-bac258a4bfe9', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('cb9c30c0-e126-4bf1-89fa-bac258a4bfe9', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb9c30c0-e126-4bf1-89fa-bac258a4bfe9', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb9c30c0-e126-4bf1-89fa-bac258a4bfe9', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('cb9c30c0-e126-4bf1-89fa-bac258a4bfe9', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d8d6eb70-09d8-440e-b5c1-c7698b243c6a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d8d6eb70-09d8-440e-b5c1-c7698b243c6a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d8d6eb70-09d8-440e-b5c1-c7698b243c6a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ca71d791-4de2-437b-94d9-8bb5bb2dbb6a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('ca71d791-4de2-437b-94d9-8bb5bb2dbb6a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dfcaa3ff-cf26-4956-854f-5d63fe15a64c', 'AUTH_TIME', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('dfcaa3ff-cf26-4956-854f-5d63fe15a64c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dfcaa3ff-cf26-4956-854f-5d63fe15a64c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dfcaa3ff-cf26-4956-854f-5d63fe15a64c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dfcaa3ff-cf26-4956-854f-5d63fe15a64c', 'auth_time', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('dfcaa3ff-cf26-4956-854f-5d63fe15a64c', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('5579c0d5-2b89-4af1-b817-504e708a94af', 'client_id', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('5579c0d5-2b89-4af1-b817-504e708a94af', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5579c0d5-2b89-4af1-b817-504e708a94af', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5579c0d5-2b89-4af1-b817-504e708a94af', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5579c0d5-2b89-4af1-b817-504e708a94af', 'client_id', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('5579c0d5-2b89-4af1-b817-504e708a94af', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('b8986993-86d2-4c3b-94d7-7512535c6e7c', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('b8986993-86d2-4c3b-94d7-7512535c6e7c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b8986993-86d2-4c3b-94d7-7512535c6e7c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b8986993-86d2-4c3b-94d7-7512535c6e7c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('b8986993-86d2-4c3b-94d7-7512535c6e7c', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('b8986993-86d2-4c3b-94d7-7512535c6e7c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d95885c5-a6a4-45bf-9fd5-ed0a722eaafd', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('d95885c5-a6a4-45bf-9fd5-ed0a722eaafd', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d95885c5-a6a4-45bf-9fd5-ed0a722eaafd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d95885c5-a6a4-45bf-9fd5-ed0a722eaafd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d95885c5-a6a4-45bf-9fd5-ed0a722eaafd', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d95885c5-a6a4-45bf-9fd5-ed0a722eaafd', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('7f4a71f3-3d5b-43ec-958e-57440f5d480b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7f4a71f3-3d5b-43ec-958e-57440f5d480b', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('7f4a71f3-3d5b-43ec-958e-57440f5d480b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7f4a71f3-3d5b-43ec-958e-57440f5d480b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7f4a71f3-3d5b-43ec-958e-57440f5d480b', 'organization', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('7f4a71f3-3d5b-43ec-958e-57440f5d480b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('b011be5a-cfef-4927-960d-94587743380a', 'false', 'single');
INSERT INTO public.protocol_mapper_config VALUES ('b011be5a-cfef-4927-960d-94587743380a', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config VALUES ('b011be5a-cfef-4927-960d-94587743380a', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config VALUES ('0963e895-2529-4555-8507-3fb75b67682b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0963e895-2529-4555-8507-3fb75b67682b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0963e895-2529-4555-8507-3fb75b67682b', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('0963e895-2529-4555-8507-3fb75b67682b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0963e895-2529-4555-8507-3fb75b67682b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0963e895-2529-4555-8507-3fb75b67682b', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0963e895-2529-4555-8507-3fb75b67682b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('0ba1e61d-58f6-49c5-8f3a-6324fcc19c37', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0ba1e61d-58f6-49c5-8f3a-6324fcc19c37', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0ba1e61d-58f6-49c5-8f3a-6324fcc19c37', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('0ba1e61d-58f6-49c5-8f3a-6324fcc19c37', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0ba1e61d-58f6-49c5-8f3a-6324fcc19c37', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('0ba1e61d-58f6-49c5-8f3a-6324fcc19c37', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('0ba1e61d-58f6-49c5-8f3a-6324fcc19c37', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('34ca67a8-d789-4ce7-819f-6773f675114c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('34ca67a8-d789-4ce7-819f-6773f675114c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('34ca67a8-d789-4ce7-819f-6773f675114c', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('34ca67a8-d789-4ce7-819f-6773f675114c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('34ca67a8-d789-4ce7-819f-6773f675114c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('34ca67a8-d789-4ce7-819f-6773f675114c', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('34ca67a8-d789-4ce7-819f-6773f675114c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('3e10e588-adc8-4b34-83d5-4bdcb2363e90', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3e10e588-adc8-4b34-83d5-4bdcb2363e90', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3e10e588-adc8-4b34-83d5-4bdcb2363e90', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('3e10e588-adc8-4b34-83d5-4bdcb2363e90', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3e10e588-adc8-4b34-83d5-4bdcb2363e90', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('3e10e588-adc8-4b34-83d5-4bdcb2363e90', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('3e10e588-adc8-4b34-83d5-4bdcb2363e90', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('5c630df6-977b-44a7-86c8-5e9e400db9f4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5c630df6-977b-44a7-86c8-5e9e400db9f4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5c630df6-977b-44a7-86c8-5e9e400db9f4', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('5c630df6-977b-44a7-86c8-5e9e400db9f4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5c630df6-977b-44a7-86c8-5e9e400db9f4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('5c630df6-977b-44a7-86c8-5e9e400db9f4', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('5c630df6-977b-44a7-86c8-5e9e400db9f4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('65c8a40c-18c8-4395-8178-388199ec55ff', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('65c8a40c-18c8-4395-8178-388199ec55ff', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('65c8a40c-18c8-4395-8178-388199ec55ff', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('65c8a40c-18c8-4395-8178-388199ec55ff', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('65c8a40c-18c8-4395-8178-388199ec55ff', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('65c8a40c-18c8-4395-8178-388199ec55ff', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('65c8a40c-18c8-4395-8178-388199ec55ff', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('67181fbd-7777-401b-87e3-d8c8cdcfcc07', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('67181fbd-7777-401b-87e3-d8c8cdcfcc07', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('67181fbd-7777-401b-87e3-d8c8cdcfcc07', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('67181fbd-7777-401b-87e3-d8c8cdcfcc07', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('67181fbd-7777-401b-87e3-d8c8cdcfcc07', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('67181fbd-7777-401b-87e3-d8c8cdcfcc07', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('67181fbd-7777-401b-87e3-d8c8cdcfcc07', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('7d1d0e6b-4dba-4da0-9259-ca3b09ebeb4a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7d1d0e6b-4dba-4da0-9259-ca3b09ebeb4a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7d1d0e6b-4dba-4da0-9259-ca3b09ebeb4a', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('7d1d0e6b-4dba-4da0-9259-ca3b09ebeb4a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7d1d0e6b-4dba-4da0-9259-ca3b09ebeb4a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('7d1d0e6b-4dba-4da0-9259-ca3b09ebeb4a', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('7d1d0e6b-4dba-4da0-9259-ca3b09ebeb4a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('91bf0504-504c-4865-93be-83733af19988', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('91bf0504-504c-4865-93be-83733af19988', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('91bf0504-504c-4865-93be-83733af19988', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('91bf0504-504c-4865-93be-83733af19988', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('91bf0504-504c-4865-93be-83733af19988', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('91bf0504-504c-4865-93be-83733af19988', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('91bf0504-504c-4865-93be-83733af19988', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('921b89f6-d213-4679-9326-2d3473c9e2e8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('921b89f6-d213-4679-9326-2d3473c9e2e8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('921b89f6-d213-4679-9326-2d3473c9e2e8', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('921b89f6-d213-4679-9326-2d3473c9e2e8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('921b89f6-d213-4679-9326-2d3473c9e2e8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('921b89f6-d213-4679-9326-2d3473c9e2e8', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('921b89f6-d213-4679-9326-2d3473c9e2e8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('a51ffee9-0752-4e9f-af0f-5cb807cb2d5c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a51ffee9-0752-4e9f-af0f-5cb807cb2d5c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a51ffee9-0752-4e9f-af0f-5cb807cb2d5c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('a51ffee9-0752-4e9f-af0f-5cb807cb2d5c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb904067-c001-4cfc-aa17-3cf565d0cc39', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb904067-c001-4cfc-aa17-3cf565d0cc39', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb904067-c001-4cfc-aa17-3cf565d0cc39', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('bb904067-c001-4cfc-aa17-3cf565d0cc39', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb904067-c001-4cfc-aa17-3cf565d0cc39', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('bb904067-c001-4cfc-aa17-3cf565d0cc39', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('bb904067-c001-4cfc-aa17-3cf565d0cc39', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c8f1469b-6338-4519-93b5-616ea036c180', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c8f1469b-6338-4519-93b5-616ea036c180', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c8f1469b-6338-4519-93b5-616ea036c180', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('c8f1469b-6338-4519-93b5-616ea036c180', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c8f1469b-6338-4519-93b5-616ea036c180', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c8f1469b-6338-4519-93b5-616ea036c180', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c8f1469b-6338-4519-93b5-616ea036c180', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('dd2af4df-54c9-4c52-8e26-897594696c0e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dd2af4df-54c9-4c52-8e26-897594696c0e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dd2af4df-54c9-4c52-8e26-897594696c0e', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('dd2af4df-54c9-4c52-8e26-897594696c0e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dd2af4df-54c9-4c52-8e26-897594696c0e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dd2af4df-54c9-4c52-8e26-897594696c0e', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('dd2af4df-54c9-4c52-8e26-897594696c0e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('2732b228-9ded-4619-b817-54dc6493831d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2732b228-9ded-4619-b817-54dc6493831d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2732b228-9ded-4619-b817-54dc6493831d', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('2732b228-9ded-4619-b817-54dc6493831d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2732b228-9ded-4619-b817-54dc6493831d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2732b228-9ded-4619-b817-54dc6493831d', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('2732b228-9ded-4619-b817-54dc6493831d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('c55b5ef0-61fa-4c5a-98f5-a26340635f74', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c55b5ef0-61fa-4c5a-98f5-a26340635f74', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c55b5ef0-61fa-4c5a-98f5-a26340635f74', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('c55b5ef0-61fa-4c5a-98f5-a26340635f74', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c55b5ef0-61fa-4c5a-98f5-a26340635f74', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('c55b5ef0-61fa-4c5a-98f5-a26340635f74', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('c55b5ef0-61fa-4c5a-98f5-a26340635f74', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d86e7f2a-ceac-491e-9dd7-d2bed80aadb8', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config VALUES ('267ecdbf-3a4d-4eb0-b812-c6a4045fabe6', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('267ecdbf-3a4d-4eb0-b812-c6a4045fabe6', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('267ecdbf-3a4d-4eb0-b812-c6a4045fabe6', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('267ecdbf-3a4d-4eb0-b812-c6a4045fabe6', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('267ecdbf-3a4d-4eb0-b812-c6a4045fabe6', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('267ecdbf-3a4d-4eb0-b812-c6a4045fabe6', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('267ecdbf-3a4d-4eb0-b812-c6a4045fabe6', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('dd307da9-1e95-4b59-a8f7-f567359bedfd', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dd307da9-1e95-4b59-a8f7-f567359bedfd', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dd307da9-1e95-4b59-a8f7-f567359bedfd', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('dd307da9-1e95-4b59-a8f7-f567359bedfd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dd307da9-1e95-4b59-a8f7-f567359bedfd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dd307da9-1e95-4b59-a8f7-f567359bedfd', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('dd307da9-1e95-4b59-a8f7-f567359bedfd', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('29380fa6-e292-40a1-bec1-b9d862035f3a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('29380fa6-e292-40a1-bec1-b9d862035f3a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dbc01bea-fd9a-4503-b0b3-689270145bd5', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dbc01bea-fd9a-4503-b0b3-689270145bd5', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('dbc01bea-fd9a-4503-b0b3-689270145bd5', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('dbc01bea-fd9a-4503-b0b3-689270145bd5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('dbc01bea-fd9a-4503-b0b3-689270145bd5', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('dbc01bea-fd9a-4503-b0b3-689270145bd5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('eca233a1-4f18-4253-86e3-271242c8f803', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('eca233a1-4f18-4253-86e3-271242c8f803', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('eca233a1-4f18-4253-86e3-271242c8f803', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('eca233a1-4f18-4253-86e3-271242c8f803', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('eca233a1-4f18-4253-86e3-271242c8f803', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('eca233a1-4f18-4253-86e3-271242c8f803', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('05f7aeeb-ec9e-4a52-b1e0-8f2d0a12b13e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('05f7aeeb-ec9e-4a52-b1e0-8f2d0a12b13e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1a2a1ba8-0159-404f-8a1f-d2e7408baddb', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1a2a1ba8-0159-404f-8a1f-d2e7408baddb', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1a2a1ba8-0159-404f-8a1f-d2e7408baddb', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('1a2a1ba8-0159-404f-8a1f-d2e7408baddb', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1a2a1ba8-0159-404f-8a1f-d2e7408baddb', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('1a2a1ba8-0159-404f-8a1f-d2e7408baddb', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('1a2a1ba8-0159-404f-8a1f-d2e7408baddb', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('cb72dc3d-bb77-4011-b3ba-503b14f2f2cd', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb72dc3d-bb77-4011-b3ba-503b14f2f2cd', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('cb72dc3d-bb77-4011-b3ba-503b14f2f2cd', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('cb72dc3d-bb77-4011-b3ba-503b14f2f2cd', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb72dc3d-bb77-4011-b3ba-503b14f2f2cd', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('cb72dc3d-bb77-4011-b3ba-503b14f2f2cd', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('cb72dc3d-bb77-4011-b3ba-503b14f2f2cd', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('03fc53ba-8186-4709-ae94-2a5c6f8168af', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('03fc53ba-8186-4709-ae94-2a5c6f8168af', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('03fc53ba-8186-4709-ae94-2a5c6f8168af', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('616c7aec-87c6-43f3-ac32-e2411cccb1d3', 'AUTH_TIME', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('616c7aec-87c6-43f3-ac32-e2411cccb1d3', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('616c7aec-87c6-43f3-ac32-e2411cccb1d3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('616c7aec-87c6-43f3-ac32-e2411cccb1d3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('616c7aec-87c6-43f3-ac32-e2411cccb1d3', 'auth_time', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('616c7aec-87c6-43f3-ac32-e2411cccb1d3', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('f4501724-1956-4652-b226-2f214c8b62bb', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('f4501724-1956-4652-b226-2f214c8b62bb', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('03167df3-c29f-4c7e-8879-72e0d874d39a', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('03167df3-c29f-4c7e-8879-72e0d874d39a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('03167df3-c29f-4c7e-8879-72e0d874d39a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('03167df3-c29f-4c7e-8879-72e0d874d39a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('03167df3-c29f-4c7e-8879-72e0d874d39a', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('03167df3-c29f-4c7e-8879-72e0d874d39a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('19cb0719-4df3-4a2e-af51-58870d58c647', 'client_id', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('19cb0719-4df3-4a2e-af51-58870d58c647', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('19cb0719-4df3-4a2e-af51-58870d58c647', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('19cb0719-4df3-4a2e-af51-58870d58c647', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('19cb0719-4df3-4a2e-af51-58870d58c647', 'client_id', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('19cb0719-4df3-4a2e-af51-58870d58c647', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('69b6ec4c-ec3b-41ab-9326-e4ce859e3ce8', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config VALUES ('69b6ec4c-ec3b-41ab-9326-e4ce859e3ce8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('69b6ec4c-ec3b-41ab-9326-e4ce859e3ce8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('69b6ec4c-ec3b-41ab-9326-e4ce859e3ce8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('69b6ec4c-ec3b-41ab-9326-e4ce859e3ce8', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('69b6ec4c-ec3b-41ab-9326-e4ce859e3ce8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('d80023ec-a184-4f1e-8f62-fa152f1e516c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d80023ec-a184-4f1e-8f62-fa152f1e516c', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config VALUES ('d80023ec-a184-4f1e-8f62-fa152f1e516c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d80023ec-a184-4f1e-8f62-fa152f1e516c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('d80023ec-a184-4f1e-8f62-fa152f1e516c', 'organization', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('d80023ec-a184-4f1e-8f62-fa152f1e516c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config VALUES ('2c132704-5c52-4094-baba-cd0e5ce50983', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2c132704-5c52-4094-baba-cd0e5ce50983', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2c132704-5c52-4094-baba-cd0e5ce50983', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config VALUES ('2c132704-5c52-4094-baba-cd0e5ce50983', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2c132704-5c52-4094-baba-cd0e5ce50983', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config VALUES ('2c132704-5c52-4094-baba-cd0e5ce50983', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config VALUES ('2c132704-5c52-4094-baba-cd0e5ce50983', 'String', 'jsonType.label');


--
-- TOC entry 4195 (class 0 OID 16439)
-- Dependencies: 216
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm VALUES ('da831425-93a2-4023-b385-9915e55fffcf', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'c228b077-1433-4c33-b76b-12fe426d2f41', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '4637261a-0c87-427e-9bd2-99dd6fbcccc6', '16b4d6ad-cfd3-4c65-811f-555277528a20', '9e0b1e34-f06d-435e-955e-94d32ae75d82', '90ed8dc3-35f7-489c-acce-98f3c072dc1f', '157d738b-1846-44f0-b92e-47eecd87a79e', 2592000, false, 900, true, false, '57f2b248-158a-47a1-9e75-c880516fc8b6', 0, false, 0, 0, '772815db-2336-467c-82d0-bd71fd6f46c7');
INSERT INTO public.realm VALUES ('0eb506ab-27da-48e4-8527-269495758e81', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'redirect-login-example', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'da718ba9-a07b-4a89-9dbb-7a301bc6ff52', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', 'f6e239d5-c24e-49f2-831d-a3ed2dbc34b8', '87b5028c-9c62-460d-baad-38318dd9811f', 'dd3e5bad-a499-4d81-8c8f-23d1ba8db4c7', '1613b3fd-59e4-4a06-ae37-c1c5b685c5e9', 'bc761cc0-46b2-4c13-a7ca-e66abbb79891', 2592000, false, 900, true, false, '5dc762c0-c343-4503-b57c-bd2bc02b4064', 0, false, 0, 0, '6add7a1a-7987-4b31-b024-377dcc7e1c96');


--
-- TOC entry 4196 (class 0 OID 16456)
-- Dependencies: 217
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'da831425-93a2-4023-b385-9915e55fffcf', '');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'da831425-93a2-4023-b385-9915e55fffcf', 'nosniff');
INSERT INTO public.realm_attribute VALUES ('_browser_header.referrerPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'no-referrer');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', 'da831425-93a2-4023-b385-9915e55fffcf', 'none');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', 'da831425-93a2-4023-b385-9915e55fffcf', 'SAMEORIGIN');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'da831425-93a2-4023-b385-9915e55fffcf', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'da831425-93a2-4023-b385-9915e55fffcf', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', 'da831425-93a2-4023-b385-9915e55fffcf', 'false');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', 'da831425-93a2-4023-b385-9915e55fffcf', 'false');
INSERT INTO public.realm_attribute VALUES ('maxTemporaryLockouts', 'da831425-93a2-4023-b385-9915e55fffcf', '0');
INSERT INTO public.realm_attribute VALUES ('bruteForceStrategy', 'da831425-93a2-4023-b385-9915e55fffcf', 'MULTIPLE');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', 'da831425-93a2-4023-b385-9915e55fffcf', '900');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', 'da831425-93a2-4023-b385-9915e55fffcf', '60');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', 'da831425-93a2-4023-b385-9915e55fffcf', '60');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', 'da831425-93a2-4023-b385-9915e55fffcf', '1000');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', 'da831425-93a2-4023-b385-9915e55fffcf', '43200');
INSERT INTO public.realm_attribute VALUES ('failureFactor', 'da831425-93a2-4023-b385-9915e55fffcf', '30');
INSERT INTO public.realm_attribute VALUES ('realmReusableOtpCode', 'da831425-93a2-4023-b385-9915e55fffcf', 'false');
INSERT INTO public.realm_attribute VALUES ('firstBrokerLoginFlowId', 'da831425-93a2-4023-b385-9915e55fffcf', 'b9905de3-dfa5-4bca-a4e9-ce3400eb9d0d');
INSERT INTO public.realm_attribute VALUES ('displayName', 'da831425-93a2-4023-b385-9915e55fffcf', 'Keycloak');
INSERT INTO public.realm_attribute VALUES ('displayNameHtml', 'da831425-93a2-4023-b385-9915e55fffcf', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO public.realm_attribute VALUES ('defaultSignatureAlgorithm', 'da831425-93a2-4023-b385-9915e55fffcf', 'RS256');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', 'da831425-93a2-4023-b385-9915e55fffcf', 'false');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', 'da831425-93a2-4023-b385-9915e55fffcf', '5184000');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', '0eb506ab-27da-48e4-8527-269495758e81', '');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xContentTypeOptions', '0eb506ab-27da-48e4-8527-269495758e81', 'nosniff');
INSERT INTO public.realm_attribute VALUES ('_browser_header.referrerPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'no-referrer');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xRobotsTag', '0eb506ab-27da-48e4-8527-269495758e81', 'none');
INSERT INTO public.realm_attribute VALUES ('_browser_header.xFrameOptions', '0eb506ab-27da-48e4-8527-269495758e81', 'SAMEORIGIN');
INSERT INTO public.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', '0eb506ab-27da-48e4-8527-269495758e81', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute VALUES ('_browser_header.strictTransportSecurity', '0eb506ab-27da-48e4-8527-269495758e81', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute VALUES ('bruteForceProtected', '0eb506ab-27da-48e4-8527-269495758e81', 'false');
INSERT INTO public.realm_attribute VALUES ('permanentLockout', '0eb506ab-27da-48e4-8527-269495758e81', 'false');
INSERT INTO public.realm_attribute VALUES ('maxTemporaryLockouts', '0eb506ab-27da-48e4-8527-269495758e81', '0');
INSERT INTO public.realm_attribute VALUES ('bruteForceStrategy', '0eb506ab-27da-48e4-8527-269495758e81', 'MULTIPLE');
INSERT INTO public.realm_attribute VALUES ('maxFailureWaitSeconds', '0eb506ab-27da-48e4-8527-269495758e81', '900');
INSERT INTO public.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', '0eb506ab-27da-48e4-8527-269495758e81', '60');
INSERT INTO public.realm_attribute VALUES ('waitIncrementSeconds', '0eb506ab-27da-48e4-8527-269495758e81', '60');
INSERT INTO public.realm_attribute VALUES ('quickLoginCheckMilliSeconds', '0eb506ab-27da-48e4-8527-269495758e81', '1000');
INSERT INTO public.realm_attribute VALUES ('maxDeltaTimeSeconds', '0eb506ab-27da-48e4-8527-269495758e81', '43200');
INSERT INTO public.realm_attribute VALUES ('failureFactor', '0eb506ab-27da-48e4-8527-269495758e81', '30');
INSERT INTO public.realm_attribute VALUES ('realmReusableOtpCode', '0eb506ab-27da-48e4-8527-269495758e81', 'false');
INSERT INTO public.realm_attribute VALUES ('defaultSignatureAlgorithm', '0eb506ab-27da-48e4-8527-269495758e81', 'RS256');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', '0eb506ab-27da-48e4-8527-269495758e81', 'false');
INSERT INTO public.realm_attribute VALUES ('offlineSessionMaxLifespan', '0eb506ab-27da-48e4-8527-269495758e81', '5184000');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByAdminLifespan', '0eb506ab-27da-48e4-8527-269495758e81', '43200');
INSERT INTO public.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan', '0eb506ab-27da-48e4-8527-269495758e81', '300');
INSERT INTO public.realm_attribute VALUES ('oauth2DeviceCodeLifespan', '0eb506ab-27da-48e4-8527-269495758e81', '600');
INSERT INTO public.realm_attribute VALUES ('oauth2DevicePollingInterval', '0eb506ab-27da-48e4-8527-269495758e81', '5');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpEntityName', '0eb506ab-27da-48e4-8527-269495758e81', 'keycloak');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicySignatureAlgorithms', '0eb506ab-27da-48e4-8527-269495758e81', 'ES256,RS256');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpId', '0eb506ab-27da-48e4-8527-269495758e81', '');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAttestationConveyancePreference', '0eb506ab-27da-48e4-8527-269495758e81', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAuthenticatorAttachment', '0eb506ab-27da-48e4-8527-269495758e81', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRequireResidentKey', '0eb506ab-27da-48e4-8527-269495758e81', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyUserVerificationRequirement', '0eb506ab-27da-48e4-8527-269495758e81', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyCreateTimeout', '0eb506ab-27da-48e4-8527-269495758e81', '0');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', '0eb506ab-27da-48e4-8527-269495758e81', 'false');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpEntityNamePasswordless', '0eb506ab-27da-48e4-8527-269495758e81', 'keycloak');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', '0eb506ab-27da-48e4-8527-269495758e81', 'ES256,RS256');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRpIdPasswordless', '0eb506ab-27da-48e4-8527-269495758e81', '');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', '0eb506ab-27da-48e4-8527-269495758e81', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', '0eb506ab-27da-48e4-8527-269495758e81', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', '0eb506ab-27da-48e4-8527-269495758e81', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', '0eb506ab-27da-48e4-8527-269495758e81', 'not specified');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyCreateTimeoutPasswordless', '0eb506ab-27da-48e4-8527-269495758e81', '0');
INSERT INTO public.realm_attribute VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', '0eb506ab-27da-48e4-8527-269495758e81', 'false');
INSERT INTO public.realm_attribute VALUES ('cibaBackchannelTokenDeliveryMode', '0eb506ab-27da-48e4-8527-269495758e81', 'poll');
INSERT INTO public.realm_attribute VALUES ('cibaExpiresIn', '0eb506ab-27da-48e4-8527-269495758e81', '120');
INSERT INTO public.realm_attribute VALUES ('cibaInterval', '0eb506ab-27da-48e4-8527-269495758e81', '5');
INSERT INTO public.realm_attribute VALUES ('cibaAuthRequestedUserHint', '0eb506ab-27da-48e4-8527-269495758e81', 'login_hint');
INSERT INTO public.realm_attribute VALUES ('parRequestUriLifespan', '0eb506ab-27da-48e4-8527-269495758e81', '60');
INSERT INTO public.realm_attribute VALUES ('firstBrokerLoginFlowId', '0eb506ab-27da-48e4-8527-269495758e81', '5966fa83-980b-4c7d-bf33-5491ebcdf9c9');


--
-- TOC entry 4237 (class 0 OID 17213)
-- Dependencies: 258
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4217 (class 0 OID 16909)
-- Dependencies: 238
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4197 (class 0 OID 16464)
-- Dependencies: 218
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_events_listeners VALUES ('da831425-93a2-4023-b385-9915e55fffcf', 'jboss-logging');
INSERT INTO public.realm_events_listeners VALUES ('0eb506ab-27da-48e4-8527-269495758e81', 'jboss-logging');


--
-- TOC entry 4270 (class 0 OID 17915)
-- Dependencies: 291
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4198 (class 0 OID 16467)
-- Dependencies: 219
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, 'da831425-93a2-4023-b385-9915e55fffcf');
INSERT INTO public.realm_required_credential VALUES ('password', 'password', true, true, '0eb506ab-27da-48e4-8527-269495758e81');


--
-- TOC entry 4199 (class 0 OID 16474)
-- Dependencies: 220
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4216 (class 0 OID 16825)
-- Dependencies: 237
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4200 (class 0 OID 16484)
-- Dependencies: 221
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.redirect_uris VALUES ('f1e2eeae-1a4e-40f5-82d1-71e1ec2eba62', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', '/realms/master/account/*');
INSERT INTO public.redirect_uris VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '/admin/master/console/*');
INSERT INTO public.redirect_uris VALUES ('0c88be54-b950-4727-9f30-a2fa8e0775be', '/realms/redirect-login-example/account/*');
INSERT INTO public.redirect_uris VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', '/realms/redirect-login-example/account/*');
INSERT INTO public.redirect_uris VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', '/admin/redirect-login-example/console/*');
INSERT INTO public.redirect_uris VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'http://localhost:8083/login/oauth2/code/*');


--
-- TOC entry 4230 (class 0 OID 17148)
-- Dependencies: 251
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4229 (class 0 OID 17141)
-- Dependencies: 250
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.required_action_provider VALUES ('04c942e2-1ab6-49b3-a443-5c86cff6d634', 'VERIFY_EMAIL', 'Verify Email', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('5d7d5132-88a9-455a-a3d3-fbc128c63dff', 'UPDATE_PROFILE', 'Update Profile', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('4cc620d5-cced-4528-b623-7060b824b22c', 'CONFIGURE_TOTP', 'Configure OTP', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('a5def035-2dfa-4784-9221-053281aafe25', 'UPDATE_PASSWORD', 'Update Password', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('025c0c75-a5fe-4e39-9cd1-7769804b74d3', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', 'da831425-93a2-4023-b385-9915e55fffcf', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider VALUES ('f9782c1c-fb7e-4964-8d50-fa3b1bb14c8b', 'delete_account', 'Delete Account', 'da831425-93a2-4023-b385-9915e55fffcf', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider VALUES ('72f6df1d-db6e-46f7-a4ff-bfa505b8bce5', 'delete_credential', 'Delete Credential', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider VALUES ('c3de1798-d5f4-474d-a1ac-867f014d5e06', 'update_user_locale', 'Update User Locale', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider VALUES ('6a9b9965-3e9d-47a7-b5ea-01d22e6a9ffe', 'CONFIGURE_RECOVERY_AUTHN_CODES', 'Recovery Authentication Codes', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'CONFIGURE_RECOVERY_AUTHN_CODES', 120);
INSERT INTO public.required_action_provider VALUES ('7f7b6bc0-4884-4dd5-9661-4b50126050bc', 'webauthn-register', 'Webauthn Register', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider VALUES ('f4ee7c6a-68e0-41cf-8de0-b4aed19e2994', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider VALUES ('3d4fcbe9-f27e-4cea-afb4-7e426f5b9d03', 'VERIFY_PROFILE', 'Verify Profile', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'VERIFY_PROFILE', 90);
INSERT INTO public.required_action_provider VALUES ('c91675f9-f5af-473b-b87d-1d0cbe8fa7c0', 'idp_link', 'Linking Identity Provider', 'da831425-93a2-4023-b385-9915e55fffcf', true, false, 'idp_link', 110);
INSERT INTO public.required_action_provider VALUES ('79b26501-b732-4137-9d8c-43c5e3869ab2', 'VERIFY_EMAIL', 'Verify Email', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider VALUES ('a16cbe59-bd45-4ca0-90ca-85335a08e00a', 'UPDATE_PROFILE', 'Update Profile', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider VALUES ('323a5837-8af1-4cc0-b4cf-04f39910270d', 'CONFIGURE_TOTP', 'Configure OTP', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider VALUES ('1a43ec28-53cb-41dd-b740-c24edd0031b0', 'UPDATE_PASSWORD', 'Update Password', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider VALUES ('d8ba99e3-ea0c-4c60-a5f1-40f94bd47524', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', '0eb506ab-27da-48e4-8527-269495758e81', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider VALUES ('0d870e6b-f082-480b-86df-17896af2c6a4', 'delete_account', 'Delete Account', '0eb506ab-27da-48e4-8527-269495758e81', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider VALUES ('2397c176-7217-4863-99dd-6fe1b8bf5bcd', 'delete_credential', 'Delete Credential', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider VALUES ('58ef3bfa-6882-4b21-93e4-9ef86f9e66f2', 'update_user_locale', 'Update User Locale', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider VALUES ('31afb4bd-1684-4550-9ea2-2b66a3ec289e', 'CONFIGURE_RECOVERY_AUTHN_CODES', 'Recovery Authentication Codes', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'CONFIGURE_RECOVERY_AUTHN_CODES', 120);
INSERT INTO public.required_action_provider VALUES ('e84dbf48-abe3-461d-a943-dbf91793fac6', 'webauthn-register', 'Webauthn Register', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider VALUES ('67bea811-8bc6-4402-bf35-dcad70724316', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider VALUES ('ff58d96d-4916-4b92-bf64-1d7d69c40317', 'VERIFY_PROFILE', 'Verify Profile', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'VERIFY_PROFILE', 90);
INSERT INTO public.required_action_provider VALUES ('cb8cceef-8926-43a5-88ce-06ddcbb3b650', 'idp_link', 'Linking Identity Provider', '0eb506ab-27da-48e4-8527-269495758e81', true, false, 'idp_link', 110);


--
-- TOC entry 4267 (class 0 OID 17846)
-- Dependencies: 288
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4247 (class 0 OID 17430)
-- Dependencies: 268
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4246 (class 0 OID 17415)
-- Dependencies: 267
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4241 (class 0 OID 17353)
-- Dependencies: 262
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4266 (class 0 OID 17822)
-- Dependencies: 287
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4244 (class 0 OID 17389)
-- Dependencies: 265
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4242 (class 0 OID 17361)
-- Dependencies: 263
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4243 (class 0 OID 17375)
-- Dependencies: 264
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4268 (class 0 OID 17864)
-- Dependencies: 289
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4273 (class 0 OID 17997)
-- Dependencies: 294
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4269 (class 0 OID 17874)
-- Dependencies: 290
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4201 (class 0 OID 16487)
-- Dependencies: 222
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scope_mapping VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', 'a132590a-4e6c-44bd-ac4a-16132c79f965');
INSERT INTO public.scope_mapping VALUES ('a19c468d-3538-42d6-a927-8e4332d92d7e', '5e842e9a-3e5e-4a09-8ccd-33b2c0196860');
INSERT INTO public.scope_mapping VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', '77f759c4-f319-40c7-ac74-49ab07885337');
INSERT INTO public.scope_mapping VALUES ('f125549a-5d8f-40d8-8637-ca427e477048', '7a31ecb6-4982-4098-af58-0a4feeb4e17e');


--
-- TOC entry 4248 (class 0 OID 17445)
-- Dependencies: 269
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4275 (class 0 OID 18013)
-- Dependencies: 296
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.server_config VALUES ('crt_jgroups', '{"prvKey":"MIIEowIBAAKCAQEA8A0YsnqdB2POo5aiboNt36wP18FitTAeEFSo0Nb6ZysmdnRfTbCAWVDLbYWcoRLifTpTJnyMkMVEZJxW57h+Qv0SDM3sXG4sFFRMhdZ5Lugxa4FXp/CKYuh8sUZmGcyMNVG1YaFFdpzwbSaFHod1vzaosM3Cz0avH1E0sZmRC18uzZkkIfIR3Q86bhB7W/u4VE6MP+R21VRpqV/To6SPt8eg8MoImRqt0voMjJyZWyvDDfNeVkvsJS8XbyO5+b1OVpGD0eoxDBNYtnEvWXNLmjcj8F8/DWqRAfSAf2OjJIIEHoyvvieSpEByLDbTpGOaPFZdHfcPEivrL8gjp5tcgwIDAQABAoIBAGmOOLfytq4TM0A38sEJxfy+2lCTVuY5fF7N+1Wp0n4fOVCJJ4cv/6BGqM1GHXOurC1IwluAFQdr1wEuxgAq3kpyocdDnZWfVH6z+to3Tx5TN7gALh1I5nFLrdj+DdN2YIjpnwqJMdRQemBkudCM3DfyvwbP08P1Xvg0aylVT7RhklCi1gjOPjSex4GOdvWFyMaPJw21xH4OIwKZgfpEEjTX9di3uQ6Y5exjV36rs2yxnvF1z1JFWj/UtI8Gs18ot7MI2WjNyk52dpZqTaF642RFoR9G8/4PofuOeh2qQjjIPS9PWcJPggHFsS+VuYifu0WluB4kuGTvRoYTf85JzdECgYEA/TxqNWj322Zk5nsDfxI/1NdsH4Ur+zn7bNEnsMI+b69EeQnOoQCxxNXUkerFYoWsenBJFrewUclOgLqpu6DaRfTp3acv+uiqr8fLSDwupSAK0mSWR6LA17E4l0voOHLUNrsXH6HG3YWtt06e+QrC5BBhbimo11VkDUC4BdWzic8CgYEA8qvXRAqTx2V56aFy2uMEqIRmgXAKPkcgw7NQNHizEYJ/MBGkxsA1IiaMnZjN+YSGcmS76kXSX3zFz5QYLzl+ChJN1akJrASYNkIgML3JE0mtxZuPqF0cP1q2/hNf2AnndJg9QDeVxhNCKtZs1LLPR2t2vSNF7wWArkD8IUlNEw0CgYEAlbwGVORnQfyOhtWP4LAKvDBQh2a39cl4CAS4AkUoo+Mvip4o5nxBoNCK62i1I6dEr/T60or0n7d3SpiUyhO3XIwPSHeV4Dd4zY1GfsTPE+YZYAQH8/2hJyhr/NHuUopbPq1rY9HFg7CKYgwD5d/eEvo4keniIskj6s4swY51pXMCgYB7DUgK6JIm+f3nykZDV/p0uS6BVB7dlZO3qKVy9gFXT6TO6yNy5OQMfR+wiltnuxuxxgLDuMQER3DG4YGh8LVIxh9RyHVvFKVaXg2Uqafcb+/90/P0m8JHHejMzWY8VklXhhsJBSadWgajUje9Yy5YONXs8oXzvgaSVcGD33eFwQKBgFNq8HaIR797MSInp71+zYJO+ZgaKWQznCbn/UN/Jt5D0AIhosQ9ZyC6QWtM5yZkacTRYNRofkeLfHr35VfzHgmwR+WWNe66wIZdrWWRfGXxKzx2ZQdb6/OwECebPvnE2geVRnFluM7mBUJR3iusHyCeKhaFPSb0DOtejz7Z5B9l","pubKey":"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8A0YsnqdB2POo5aiboNt36wP18FitTAeEFSo0Nb6ZysmdnRfTbCAWVDLbYWcoRLifTpTJnyMkMVEZJxW57h+Qv0SDM3sXG4sFFRMhdZ5Lugxa4FXp/CKYuh8sUZmGcyMNVG1YaFFdpzwbSaFHod1vzaosM3Cz0avH1E0sZmRC18uzZkkIfIR3Q86bhB7W/u4VE6MP+R21VRpqV/To6SPt8eg8MoImRqt0voMjJyZWyvDDfNeVkvsJS8XbyO5+b1OVpGD0eoxDBNYtnEvWXNLmjcj8F8/DWqRAfSAf2OjJIIEHoyvvieSpEByLDbTpGOaPFZdHfcPEivrL8gjp5tcgwIDAQAB","crt":"MIICnTCCAYUCBgGYa3SJiDANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdqZ3JvdXBzMB4XDTI1MDgwMjE1NDIzNloXDTI1MTAwMTE1NDQxNVowEjEQMA4GA1UEAwwHamdyb3VwczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAPANGLJ6nQdjzqOWom6Dbd+sD9fBYrUwHhBUqNDW+mcrJnZ0X02wgFlQy22FnKES4n06UyZ8jJDFRGScVue4fkL9EgzN7FxuLBRUTIXWeS7oMWuBV6fwimLofLFGZhnMjDVRtWGhRXac8G0mhR6Hdb82qLDNws9Grx9RNLGZkQtfLs2ZJCHyEd0POm4Qe1v7uFROjD/kdtVUaalf06Okj7fHoPDKCJkardL6DIycmVsrww3zXlZL7CUvF28jufm9TlaRg9HqMQwTWLZxL1lzS5o3I/BfPw1qkQH0gH9joySCBB6Mr74nkqRAciw206RjmjxWXR33DxIr6y/II6ebXIMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAhxLxqNoqIZSEFZVAX1dl1cMdBHjaKAXSaPk5ilO7C92QKdD+QjTsLnBKnqKSxZkl9FelNwwYj96wrAaH9aGaGU1ndR9aTwl7yf8EH1kN7ZfogC6Onqvods29k6ZgWQ6chGVY+b3+sKQIgPwv+ZprSFOAjaqf/OmrYAbMu/BsVfa0Yc7FUU8fPgi4+EF1hwFEWfFGQtkCDlbbYaDqhfeRA4/uMFFePWTcSygfQZXcjNnOBOcu2kpVkpz1HDN8CDznqCBfmrMzzTLLCrMIMiOG1zW2gFpyuVp5FQsPkwn+6wlvkly60TadX6j/nxz+b+qV9NsWRejcT0WEdjGui6b9xQ==","alias":"a54b24ea-49d8-4dfd-aaf2-e520ec34c72a","generatedMillis":1754149456315}', 0);


--
-- TOC entry 4202 (class 0 OID 16493)
-- Dependencies: 223
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_attribute VALUES ('is_temporary_admin', 'true', 'aafd57d6-7a32-4fd4-9829-c3bcc3ca2fd4', '23c6926b-bbeb-470e-b3f6-748a42649a37', NULL, NULL, NULL);


--
-- TOC entry 4221 (class 0 OID 16930)
-- Dependencies: 242
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4264 (class 0 OID 17797)
-- Dependencies: 285
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4203 (class 0 OID 16498)
-- Dependencies: 224
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_entity VALUES ('aafd57d6-7a32-4fd4-9829-c3bcc3ca2fd4', NULL, '70048418-cea7-4ef8-b2c0-4049d5cced5d', false, true, NULL, NULL, NULL, 'da831425-93a2-4023-b385-9915e55fffcf', 'admin', 1754149458508, NULL, 0);
INSERT INTO public.user_entity VALUES ('a1df2af0-061e-4157-8636-63a9790a0615', 'oidcuserexample@example.com', 'oidcuserexample@example.com', true, true, NULL, 'oidcUser', 'example', '0eb506ab-27da-48e4-8527-269495758e81', 'oidc-user', 1754246715281, NULL, 0);


--
-- TOC entry 4204 (class 0 OID 16506)
-- Dependencies: 225
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4227 (class 0 OID 17042)
-- Dependencies: 248
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4228 (class 0 OID 17047)
-- Dependencies: 249
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4205 (class 0 OID 16511)
-- Dependencies: 226
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4236 (class 0 OID 17210)
-- Dependencies: 257
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4206 (class 0 OID 16516)
-- Dependencies: 227
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4207 (class 0 OID 16519)
-- Dependencies: 228
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_role_mapping VALUES ('772815db-2336-467c-82d0-bd71fd6f46c7', 'aafd57d6-7a32-4fd4-9829-c3bcc3ca2fd4');
INSERT INTO public.user_role_mapping VALUES ('31e73975-4760-430f-b56b-048f28b55a85', 'aafd57d6-7a32-4fd4-9829-c3bcc3ca2fd4');
INSERT INTO public.user_role_mapping VALUES ('6add7a1a-7987-4b31-b024-377dcc7e1c96', 'a1df2af0-061e-4157-8636-63a9790a0615');


--
-- TOC entry 4208 (class 0 OID 16533)
-- Dependencies: 229
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.web_origins VALUES ('cd96a33a-0b7a-4f48-a2c1-84bfe8596fad', '+');
INSERT INTO public.web_origins VALUES ('56c66833-c8cd-499b-a921-3ef063da04ed', '+');
INSERT INTO public.web_origins VALUES ('a24691f3-e86b-4aae-a732-736c5578a0db', 'http://localhost:8083');


--
-- TOC entry 3973 (class 2606 OID 17986)
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- TOC entry 3965 (class 2606 OID 17975)
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- TOC entry 3981 (class 2606 OID 18020)
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- TOC entry 3695 (class 2606 OID 17898)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3934 (class 2606 OID 17728)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3936 (class 2606 OID 17927)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3931 (class 2606 OID 17603)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3846 (class 2606 OID 17251)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3894 (class 2606 OID 17526)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3922 (class 2606 OID 17546)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3925 (class 2606 OID 17544)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3914 (class 2606 OID 17542)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3896 (class 2606 OID 17528)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3901 (class 2606 OID 17530)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3906 (class 2606 OID 17536)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3910 (class 2606 OID 17538)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3918 (class 2606 OID 17540)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3929 (class 2606 OID 17583)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3848 (class 2606 OID 17687)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3777 (class 2606 OID 17704)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3709 (class 2606 OID 17706)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3774 (class 2606 OID 17708)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3765 (class 2606 OID 16837)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3750 (class 2606 OID 16771)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3692 (class 2606 OID 16545)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3761 (class 2606 OID 16839)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3701 (class 2606 OID 16547)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3738 (class 2606 OID 16553)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3680 (class 2606 OID 16557)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3719 (class 2606 OID 16561)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3753 (class 2606 OID 16775)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3706 (class 2606 OID 16563)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3712 (class 2606 OID 16565)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3697 (class 2606 OID 16567)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3799 (class 2606 OID 17691)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3812 (class 2606 OID 17068)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3808 (class 2606 OID 17066)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3805 (class 2606 OID 17064)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3802 (class 2606 OID 17062)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3744 (class 2606 OID 16569)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3685 (class 2606 OID 17685)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3772 (class 2606 OID 16841)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3880 (class 2606 OID 17409)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3714 (class 2606 OID 16571)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3689 (class 2606 OID 16573)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3736 (class 2606 OID 16575)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3950 (class 2606 OID 17826)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3865 (class 2606 OID 17367)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3875 (class 2606 OID 17395)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3891 (class 2606 OID 17464)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3885 (class 2606 OID 17434)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3870 (class 2606 OID 17381)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3882 (class 2606 OID 17419)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3888 (class 2606 OID 17449)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3728 (class 2606 OID 16577)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3818 (class 2606 OID 17076)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3814 (class 2606 OID 17074)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3948 (class 2606 OID 17811)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3944 (class 2606 OID 17801)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3792 (class 2606 OID 16949)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3832 (class 2606 OID 17218)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3839 (class 2606 OID 17225)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3836 (class 2606 OID 17239)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3787 (class 2606 OID 16945)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3790 (class 2606 OID 17125)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3979 (class 2606 OID 18012)
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- TOC entry 3780 (class 2606 OID 16943)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3830 (class 2606 OID 17904)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3825 (class 2606 OID 17195)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3755 (class 2606 OID 16835)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3759 (class 2606 OID 17118)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3716 (class 2606 OID 17710)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3823 (class 2606 OID 17158)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3820 (class 2606 OID 17156)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3741 (class 2606 OID 17070)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3958 (class 2606 OID 17873)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3960 (class 2606 OID 17880)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3976 (class 2606 OID 18001)
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- TOC entry 3722 (class 2606 OID 17154)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3843 (class 2606 OID 17232)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3747 (class 2606 OID 17712)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3678 (class 2606 OID 16389)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3857 (class 2606 OID 17335)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3852 (class 2606 OID 17294)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3863 (class 2606 OID 17665)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3861 (class 2606 OID 17323)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3942 (class 2606 OID 17786)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3963 (class 2606 OID 17921)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3956 (class 2606 OID 17853)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3834 (class 2606 OID 17595)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3770 (class 2606 OID 16892)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3683 (class 2606 OID 16581)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3854 (class 2606 OID 17739)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3732 (class 2606 OID 16585)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3795 (class 2606 OID 17990)
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3868 (class 2606 OID 17912)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3954 (class 2606 OID 17908)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3878 (class 2606 OID 17656)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3873 (class 2606 OID 17660)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3797 (class 2606 OID 17988)
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- TOC entry 3783 (class 2606 OID 18025)
-- Name: migration_model uk_migration_update_time; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_update_time UNIQUE (update_time);


--
-- TOC entry 3785 (class 2606 OID 18023)
-- Name: migration_model uk_migration_version; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_version UNIQUE (version);


--
-- TOC entry 3967 (class 2606 OID 17994)
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- TOC entry 3969 (class 2606 OID 17979)
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- TOC entry 3971 (class 2606 OID 17977)
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- TOC entry 3704 (class 2606 OID 16593)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3734 (class 2606 OID 17585)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3897 (class 1259 OID 17961)
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3898 (class 1259 OID 17963)
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3800 (class 1259 OID 17937)
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 3892 (class 1259 OID 17609)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3803 (class 1259 OID 17613)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3809 (class 1259 OID 17611)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3810 (class 1259 OID 17610)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3806 (class 1259 OID 17612)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3937 (class 1259 OID 17928)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3751 (class 1259 OID 17964)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- TOC entry 3681 (class 1259 OID 17913)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3932 (class 1259 OID 17653)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3855 (class 1259 OID 17816)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3938 (class 1259 OID 17925)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3756 (class 1259 OID 17813)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3858 (class 1259 OID 17814)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3923 (class 1259 OID 17619)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3926 (class 1259 OID 17887)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3927 (class 1259 OID 17618)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3686 (class 1259 OID 17620)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3687 (class 1259 OID 17621)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3939 (class 1259 OID 17819)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3940 (class 1259 OID 17820)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3693 (class 1259 OID 17914)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3762 (class 1259 OID 17352)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3763 (class 1259 OID 17351)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3899 (class 1259 OID 17713)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3902 (class 1259 OID 17733)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3903 (class 1259 OID 17896)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3904 (class 1259 OID 17715)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3907 (class 1259 OID 17716)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3908 (class 1259 OID 17717)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3911 (class 1259 OID 17718)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3912 (class 1259 OID 17719)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3915 (class 1259 OID 17720)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3916 (class 1259 OID 17721)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3919 (class 1259 OID 17722)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3920 (class 1259 OID 17723)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3840 (class 1259 OID 17939)
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3841 (class 1259 OID 17624)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3837 (class 1259 OID 17625)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3788 (class 1259 OID 17627)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3766 (class 1259 OID 17626)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3767 (class 1259 OID 18005)
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- TOC entry 3768 (class 1259 OID 18004)
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- TOC entry 3698 (class 1259 OID 17628)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3699 (class 1259 OID 17629)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3826 (class 1259 OID 17968)
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- TOC entry 3827 (class 1259 OID 17967)
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- TOC entry 3828 (class 1259 OID 17932)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3974 (class 1259 OID 17996)
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- TOC entry 3951 (class 1259 OID 17992)
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- TOC entry 3952 (class 1259 OID 17991)
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- TOC entry 3757 (class 1259 OID 17630)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3707 (class 1259 OID 17633)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3850 (class 1259 OID 17812)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3849 (class 1259 OID 17634)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3710 (class 1259 OID 17637)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3778 (class 1259 OID 17636)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3702 (class 1259 OID 17632)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3775 (class 1259 OID 17638)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3717 (class 1259 OID 17639)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3821 (class 1259 OID 17640)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3886 (class 1259 OID 17641)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3883 (class 1259 OID 17642)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3876 (class 1259 OID 17661)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3866 (class 1259 OID 17662)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3871 (class 1259 OID 17663)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3977 (class 1259 OID 18002)
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- TOC entry 3961 (class 1259 OID 17886)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3859 (class 1259 OID 17815)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3720 (class 1259 OID 17646)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3889 (class 1259 OID 17647)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3781 (class 1259 OID 17894)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3945 (class 1259 OID 17821)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3946 (class 1259 OID 17938)
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- TOC entry 3723 (class 1259 OID 17348)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3724 (class 1259 OID 17935)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3793 (class 1259 OID 17345)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3690 (class 1259 OID 17349)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3729 (class 1259 OID 17342)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3844 (class 1259 OID 17344)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3742 (class 1259 OID 17350)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3745 (class 1259 OID 17343)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3730 (class 1259 OID 17936)
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 3815 (class 1259 OID 17649)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3816 (class 1259 OID 17650)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3739 (class 1259 OID 17651)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3748 (class 1259 OID 17652)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3725 (class 1259 OID 17960)
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3726 (class 1259 OID 17962)
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 4004 (class 2606 OID 16846)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3998 (class 2606 OID 16776)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 4003 (class 2606 OID 16856)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3999 (class 2606 OID 17003)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3990 (class 2606 OID 16601)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3994 (class 2606 OID 16606)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3988 (class 2606 OID 16616)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4046 (class 2606 OID 17854)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3992 (class 2606 OID 16621)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3995 (class 2606 OID 16631)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3985 (class 2606 OID 16636)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3989 (class 2606 OID 16641)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3986 (class 2606 OID 16656)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3982 (class 2606 OID 16661)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 4013 (class 2606 OID 17097)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 4014 (class 2606 OID 17092)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4012 (class 2606 OID 17087)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4011 (class 2606 OID 17082)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3996 (class 2606 OID 16671)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 4023 (class 2606 OID 17760)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 4024 (class 2606 OID 17750)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 4000 (class 2606 OID 17745)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 4039 (class 2606 OID 17604)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4037 (class 2606 OID 17552)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 4038 (class 2606 OID 17547)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4022 (class 2606 OID 17252)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4017 (class 2606 OID 17112)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 4015 (class 2606 OID 17107)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 4016 (class 2606 OID 17102)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4035 (class 2606 OID 17470)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 4033 (class 2606 OID 17455)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 4042 (class 2606 OID 17827)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 4025 (class 2606 OID 17671)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 4043 (class 2606 OID 17832)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 4044 (class 2606 OID 17837)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 4036 (class 2606 OID 17465)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 4034 (class 2606 OID 17450)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 4045 (class 2606 OID 17859)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 4027 (class 2606 OID 17666)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 4029 (class 2606 OID 17420)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 4031 (class 2606 OID 17435)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 4032 (class 2606 OID 17440)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 4030 (class 2606 OID 17425)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 4026 (class 2606 OID 17676)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3983 (class 2606 OID 16686)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 4041 (class 2606 OID 17802)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 4010 (class 2606 OID 16966)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 4020 (class 2606 OID 17226)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 4019 (class 2606 OID 17240)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 4007 (class 2606 OID 16912)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3987 (class 2606 OID 16696)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4008 (class 2606 OID 16956)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4009 (class 2606 OID 17126)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3997 (class 2606 OID 16706)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3991 (class 2606 OID 16716)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 4001 (class 2606 OID 16851)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3984 (class 2606 OID 16731)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 4002 (class 2606 OID 17119)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 4040 (class 2606 OID 17787)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4018 (class 2606 OID 17161)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4047 (class 2606 OID 17867)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 4048 (class 2606 OID 17881)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 4006 (class 2606 OID 16881)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3993 (class 2606 OID 16751)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 4021 (class 2606 OID 17233)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 4028 (class 2606 OID 17410)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 4005 (class 2606 OID 16861)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- TOC entry 4283 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-08-03 16:51:46 -03

--
-- PostgreSQL database dump complete
--

