
create table "public"."lacr" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "creator" uuid not null,
    "decision_date" timestamp with time zone,
    "coordination_start" timestamp with time zone,
    "coordination_end" timestamp with time zone,
    "status" text not null default '''draft''::text'::text,
    "creator_office" bigint not null,
    "lead_office" bigint
);


alter table "public"."lacr" enable row level security;

CREATE UNIQUE INDEX lacr_pkey ON public.lacr USING btree (id);

alter table "public"."lacr" add constraint "lacr_pkey" PRIMARY KEY using index "lacr_pkey";

alter table "public"."lacr" add constraint "lacr_creator_fkey" FOREIGN KEY (creator) REFERENCES users(id) not valid;

alter table "public"."lacr" validate constraint "lacr_creator_fkey";

alter table "public"."lacr" add constraint "lacr_creator_office_fkey" FOREIGN KEY (creator_office) REFERENCES offices(id) not valid;

alter table "public"."lacr" validate constraint "lacr_creator_office_fkey";

alter table "public"."lacr" add constraint "lacr_lead_office_fkey" FOREIGN KEY (lead_office) REFERENCES offices(id) not valid;

alter table "public"."lacr" validate constraint "lacr_lead_office_fkey";

alter table "public"."lacr" add constraint "lacr_status_check" CHECK ((status = ANY (ARRAY['draft'::text, 'active'::text, 'complete'::text]))) not valid;

alter table "public"."lacr" validate constraint "lacr_status_check";


