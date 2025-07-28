-- Table: public.clients

-- DROP TABLE IF EXISTS public.clients;

CREATE TABLE IF NOT EXISTS public.clients
(
    client_id integer NOT NULL DEFAULT nextval('clients_client_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default",
    email character varying(100) COLLATE pg_catalog."default",
    country character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT clients_pkey PRIMARY KEY (client_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.clients
    OWNER to postgres;



-- Table: public.freelancers

-- DROP TABLE IF EXISTS public.freelancers;

CREATE TABLE IF NOT EXISTS public.freelancers
(
    freelancer_id integer NOT NULL DEFAULT nextval('freelancers_freelancer_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default",
    email character varying(100) COLLATE pg_catalog."default",
    skills text COLLATE pg_catalog."default",
    country character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT freelancers_pkey PRIMARY KEY (freelancer_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.freelancers
    OWNER to postgres;


-- Table: public.payments

-- DROP TABLE IF EXISTS public.payments;

CREATE TABLE IF NOT EXISTS public.payments
(
    payment_id integer NOT NULL DEFAULT nextval('payments_payment_id_seq'::regclass),
    work_id integer,
    amount numeric,
    payment_date date,
    platform_fee numeric,
    CONSTRAINT payments_pkey PRIMARY KEY (payment_id),
    CONSTRAINT payments_work_id_fkey FOREIGN KEY (work_id)
        REFERENCES public.project_work (work_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.payments
    OWNER to postgres;




-- Table: public.project_work

-- DROP TABLE IF EXISTS public.project_work;

CREATE TABLE IF NOT EXISTS public.project_work
(
    work_id integer NOT NULL DEFAULT nextval('project_work_work_id_seq'::regclass),
    project_id integer,
    freelancer_id integer,
    start_date date,
    end_date date,
    status character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT project_work_pkey PRIMARY KEY (work_id),
    CONSTRAINT project_work_freelancer_id_fkey FOREIGN KEY (freelancer_id)
        REFERENCES public.freelancers (freelancer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT project_work_project_id_fkey FOREIGN KEY (project_id)
        REFERENCES public.projects (project_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.project_work
    OWNER to postgres;




-- Table: public.projects

-- DROP TABLE IF EXISTS public.projects;

CREATE TABLE IF NOT EXISTS public.projects
(
    project_id integer NOT NULL DEFAULT nextval('projects_project_id_seq'::regclass),
    client_id integer,
    title character varying(200) COLLATE pg_catalog."default",
    category character varying(50) COLLATE pg_catalog."default",
    budget numeric,
    post_date date,
    CONSTRAINT projects_pkey PRIMARY KEY (project_id),
    CONSTRAINT projects_client_id_fkey FOREIGN KEY (client_id)
        REFERENCES public.clients (client_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.projects
    OWNER to postgres;





-- Table: public.proposals

-- DROP TABLE IF EXISTS public.proposals;

CREATE TABLE IF NOT EXISTS public.proposals
(
    proposal_id integer NOT NULL DEFAULT nextval('proposals_proposal_id_seq'::regclass),
    project_id integer,
    freelancer_id integer,
    proposal_date date,
    proposed_amount numeric,
    CONSTRAINT proposals_pkey PRIMARY KEY (proposal_id),
    CONSTRAINT proposals_freelancer_id_fkey FOREIGN KEY (freelancer_id)
        REFERENCES public.freelancers (freelancer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT proposals_project_id_fkey FOREIGN KEY (project_id)
        REFERENCES public.projects (project_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.proposals
    OWNER to postgres;