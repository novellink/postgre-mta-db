/* 삭제시 의존성이 있어서 다음 순서로 삭제 해야 한다.
DROP TABLE public.health_al;
DROP TABLE public.health_bc;
DROP TABLE public.health_bp; 
DROP TABLE public.health_bs;
DROP TABLE public.health_cm;
DROP TABLE public.health_hrv;
DROP TABLE public.health_hs;
DROP TABLE public.health_lu;
DROP TABLE public.health_users;
DROP TABLE public.health;

DROP TABLE public.users_refresh_tokens;
DROP TABLE public.users_site;
DROP TABLE public.users_accounts;
DROP TABLE public.users_log;
DROP TABLE public.users_health_data;
DROP TABLE public.users;

DROP TABLE public.code;
DROP TABLE public.cde_type;
 */



CREATE TABLE public.code_type (
    id smallint NOT NULL PRIMARY KEY,
    name character varying(200) NOT NULL
);




CREATE TABLE public.code (
    id smallint NOT NULL PRIMARY KEY,
    name character varying(200) NOT NULL,
    type_id smallint NOT NULL REFERENCES code_type (id) ON UPDATE CASCADE
);




CREATE TABLE public.users (
id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
user_name varchar(100) NOT NULL,
phone varchar(11) NOT NULL CHECK (phone ~ '^[0-9]{10,11}$'),
gender boolean NOT NULL DEFAULT TRUE,
birth_date date NOT NULL,
is_site boolean NOT NULL DEFAULT FALSE,
created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
UNIQUE (phone)
);


CREATE TABLE public.users_refresh_tokens(
id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
user_id bigint NOT NULL REFERENCES users(id) ON DELETE CASCADE,
refresh_token text NOT NULL ,
expired_at TIMESTAMPTZ NOT NULL,
UNIQUE (user_id,refresh_token)
)

CREATE TABLE public.users_site(
user_id bigint NOT NULL PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
site_token text NOT NULL UNIQUE,
site_name varchar(100) NOT NULL,
site_logo_url varchar NOT NULL,
);

CREATE TABLE public.users_accounts(
id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
user_id bigint NOT NULL REFERENCES users(id) ON DELETE CASCADE,
provider smallint NOT NULL REFERENCES code(id) ON UPDATE CASCADE ,
provider_sub text NOT NULL,
email text NOT NULL,
UNIQUE(provider,provider_sub),
UNIQUE(user_id,provider)
)

CREATE TABLE public.users_health_data(
id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
user_id bigint NOT NULL REFERENCES users(id) ON DELETE CASCADE,
data_dt TIMESTAMPTZ NOT NULL,
memo varchar(50) NOT NULL DEFAULT ' ',
health_data_type SMALLINT NOT NULL REFERENCES code(id) ON UPDATE CASCADE,
measurement_type smallint NOT NULL REFERENCES code(id) ON UPDATE CASCADE,
unique(user_id,data_dt,health_data_type)
)

CREATE TABLE public.users_log(
user_id bigint NOT NULL REFERENCES users(id) ON DELETE CASCADE,
log_dt TIMESTAMPTZ NOT NULL,
log text NOT NULL DEFAULT ' ',
log_type smallint NOT NULL REFERENCES code(id) ON UPDATE CASCADE
)

CREATE TABLE public.health(
id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
gender boolean NOT NULL DEFAULT TRUE,
birth_dt date NOT NULL
)

CREATE TABLE public.health_users(
health_id bigint NOT NULL REFERENCES health(id) ON DELETE CASCADE,
user_id bigint NOT NULL REFERENCES users(id) ON DELETE CASCADE,
PRIMARY KEY(health_id,user_id)
)

CREATE TABLE public.health_al(
id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
health_id bigint NOT NULL REFERENCES health(id) ON DELETE CASCADE,
data_dt TIMESTAMPTZ NOT NULL,
alcohol_result boolean NOT NULL DEFAULT FALSE,
alcohol_yang NUMERIC(6,2) NOT NULL,
unique(health_id,data_dt)
)

CREATE TABLE public.health_bc (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    health_id BIGINT NOT NULL REFERENCES health(id) ON DELETE CASCADE,
    data_dt TIMESTAMPTZ NOT NULL,
    weight NUMERIC(6,2) NOT NULL,
    weight_result VARCHAR(50) NOT NULL,
    fatyang NUMERIC(6,2) NOT NULL,
    fatyang_result VARCHAR(50) NOT NULL,
    muscleyang NUMERIC(6,2) NOT NULL,
    muscleyang_result VARCHAR(50) NOT NULL,
    adult_bodytype VARCHAR(50) NOT NULL,
    basalmetabolism NUMERIC(6,2) NOT NULL,
    golgyeokgeunyang NUMERIC(6,2) NOT NULL,
    bmi NUMERIC(5,2) NOT NULL,
    fatryul NUMERIC(5,2) NOT NULL,
    fatryul_result VARCHAR(50) NOT NULL,
    naejangfat_level NUMERIC(5,2) NOT NULL,
    wateryang NUMERIC(6,2) NOT NULL,
    mineralsyang NUMERIC(6,2) NOT NULL,
    proteinyang NUMERIC(6,2) NOT NULL,
    total_grade NUMERIC(5,2) NOT NULL,
    UNIQUE (health_id, data_dt)
);

CREATE TABLE public.health_bp (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    health_id BIGINT NOT NULL REFERENCES health(id) ON DELETE CASCADE,
    data_dt TIMESTAMPTZ NOT NULL,

    high INT NOT NULL,
    low INT NOT NULL,
    pulse INT NOT NULL,
    status VARCHAR(50) NOT NULL,

    UNIQUE (health_id, data_dt)
);


CREATE TABLE public.health_bs (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    health_id BIGINT NOT NULL REFERENCES health(id) ON DELETE CASCADE,
    data_dt TIMESTAMPTZ NOT NULL,

    status VARCHAR(50) NOT NULL,
    bloodsugar_type VARCHAR(50) NOT NULL,
    bloodsugar INT NOT NULL,
    col_total INT NOT NULL,
    col_tri INT NOT NULL,
    col_ldl INT NOT NULL,
    col_hdl INT NOT NULL,

    UNIQUE (health_id, data_dt)
);

CREATE TABLE public.health_cm (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    health_id BIGINT NOT NULL REFERENCES health(id) ON DELETE CASCADE,
    data_dt TIMESTAMPTZ NOT NULL,
    value boolean NOT NULL DEFAULT true,
    UNIQUE (health_id, data_dt)
);



CREATE TABLE public.health_hs (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    health_id BIGINT NOT NULL REFERENCES health(id) ON DELETE CASCADE,
    data_dt TIMESTAMPTZ NOT NULL,

    height NUMERIC(6,2) NOT NULL,
    weight NUMERIC(6,2) NOT NULL,
    bmi VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,

    UNIQUE (health_id, data_dt)
);


CREATE TABLE public.health_lu (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    health_id BIGINT NOT NULL REFERENCES health(id) ON DELETE CASCADE,
    data_dt TIMESTAMPTZ NOT NULL,

    fvc_1 NUMERIC(6,2) NOT NULL,
    fvc_p_1 NUMERIC(6,2) NOT NULL,
    fev1_1 NUMERIC(6,2) NOT NULL,
    fev1_p_1 NUMERIC(6,2) NOT NULL,
    fev1fvc_1 NUMERIC(6,2) NOT NULL,
    fev1fvc_status_1 VARCHAR(50) NOT NULL,
    fef2575_1 NUMERIC(6,2) NOT NULL,
    pef_1 NUMERIC(6,2) NOT NULL,
    pef_p_1 NUMERIC(6,2) NOT NULL,
    lung_age_1 NUMERIC(6,2) NOT NULL,

    fvc_2 NUMERIC(6,2) NOT NULL,
    fvc_p_2 NUMERIC(6,2) NOT NULL,
    fev1_2 NUMERIC(6,2) NOT NULL,
    fev1_p_2 NUMERIC(6,2) NOT NULL,
    fev1fvc_2 NUMERIC(6,2) NOT NULL,
    fev1fvc_status_2 VARCHAR(50) NOT NULL,
    fef2575_2 NUMERIC(6,2) NOT NULL,
    pef_2 NUMERIC(6,2) NOT NULL,
    pef_p_2 NUMERIC(6,2) NOT NULL,
    lung_age_2 NUMERIC(6,2) NOT NULL,

    fvc_3 NUMERIC(6,2) NOT NULL,
    fvc_p_3 NUMERIC(6,2) NOT NULL,
    fev1_3 NUMERIC(6,2) NOT NULL,
    fev1_p_3 NUMERIC(6,2) NOT NULL,
    fev1fvc_3 NUMERIC(6,2) NOT NULL,
    fev1fvc_status_3 VARCHAR(50) NOT NULL,
    fef2575_3 NUMERIC(6,2) NOT NULL,
    pef_3 NUMERIC(6,2) NOT NULL,
    pef_p_3 NUMERIC(6,2) NOT NULL,
    lung_age_3 NUMERIC(6,2) NOT NULL,

    UNIQUE (health_id, data_dt)
);
CREATE TABLE public.health_st (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    health_id BIGINT NOT NULL REFERENCES health(id) ON DELETE CASCADE,
    data_dt TIMESTAMPTZ NOT NULL,

    heartrate_avg NUMERIC(6,2) NOT NULL,
    heartrate_score NUMERIC(6,2) NOT NULL,
    heartrate_step VARCHAR(50) NOT NULL,
    heartrate_ng INT NOT NULL,
    jayul_activity_score NUMERIC(6,2) NOT NULL,
    jayul_activity_step VARCHAR(50) NOT NULL,
    piro_score NUMERIC(6,2) NOT NULL,
    piro_step VARCHAR(50) NOT NULL,
    heart_stability_score NUMERIC(6,2) NOT NULL,
    heart_stability_step VARCHAR(50) NOT NULL,
    jayul_balance_step NUMERIC(6,2) NOT NULL,
    physical_stress_score NUMERIC(6,2) NOT NULL,
    physical_stress_step VARCHAR(50) NOT NULL,
    mental_stress_score NUMERIC(6,2) NOT NULL,
    mental_stress_step VARCHAR(50) NOT NULL,
    stress_ability_score NUMERIC(6,2) NOT NULL,
    stress_ability_step VARCHAR(50) NOT NULL,
    total_grade NUMERIC(6,2) NOT NULL,
    dongmaek_tansung_score NUMERIC(6,2) NOT NULL,
    dongmaek_tansung_step VARCHAR(50) NOT NULL,
    malcho_tansung_score NUMERIC(6,2) NOT NULL,
    malcho_tansung_step VARCHAR(50) NOT NULL,
    bloodvessel_age NUMERIC(6,2) NOT NULL,
    bloodvessel_score NUMERIC(6,2) NOT NULL,
    bloodvessel_step VARCHAR(50) NOT NULL,
    bloodvessel_step_status VARCHAR(50) NOT NULL,

    UNIQUE (health_id, data_dt)
);

CREATE TABLE public.health_va (
	id  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	health_id  BIGINT NOT NULL REFERENCES health(id) ON DELETE CASCADE,
	data_dt timestamptz NOT NULL,
	"left" numeric(6, 2) NOT NULL,
	left_status varchar(50) NOT NULL,
	"right" numeric(6, 2) NOT NULL,
	right_status varchar(50) NOT NULL,
	status varchar(50) NOT NULL,
	UNIQUE (health_id, data_dt)
);


