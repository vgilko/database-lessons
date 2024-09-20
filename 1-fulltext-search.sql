select left(body_plain, 200)
from mail_messages
    limit 1;

select count(*)
from mail_messages;

select id, subject
from mail_messages
where to_tsvector(subject) @@ to_tsquery('magical');

select id, subject
from mail_messages
where to_tsvector(subject) @@ to_tsquery('magic & value');

select id, subject
from mail_messages
where to_tsvector(subject) @@ to_tsquery('magic & value &!time');

select id, subject
from mail_messages
where to_tsvector(subject) @@ to_tsquery('magic & (value | constant)');

select id, subject
from mail_messages
where to_tsvector(subject) @@ to_tsquery('time <-> value');

select id, subject
from mail_messages
where to_tsvector(subject) @@ to_tsquery('time <2> value');

select id, subject
from mail_messages
where to_tsvector(subject) @@ websearch_to_tsquery('"time value" & -magic');

select id,
       ts_headline(
               body_plain,
               to_tsquery('magic'),
               'StartSel=">>>",StopSel="<<<",MinWords=3,MaxWords=10'
           )
from mail_messages
where to_tsvector(body_plain) @@ to_tsquery('magic');

show default_text_search_config;

alter text search configuration english
    alter mapping for word with simple, english_stem;


alter table mail_messages
    add search_vector tsvector GENERATED ALWAYS AS (
            to_tsvector('english', subject) || to_tsvector('english', body_plain)
        ) stored;
