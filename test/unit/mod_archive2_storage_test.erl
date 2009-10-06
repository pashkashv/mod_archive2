%%%----------------------------------------------------------------------
%%% File    : mod_archive2_odbc_test.erl
%%% Author  : Alexander Tsvyashchenko <ejabberd@ndl.kiev.ua>
%%% Purpose : Message Archiving (XEP-136) Storage Support
%%% Created : 3 Oct 2009 by Alexander Tsvyashchenko <ejabberd@ndl.kiev.ua>
%%% Version : 2.0.0
%%% Id      : $Id$
%%%----------------------------------------------------------------------

-module(mod_archive2_storage_test).
-author('ejabberd@ndl.kiev.ua').

-include_lib("stdlib/include/ms_transform.hrl").
-include("mod_archive2.hrl").
-include("testing.hrl").

-export([eunit_xml_report/1]).

-define(HOST, "localhost").

eunit_xml_report(OutDir) -> ?EUNIT_XML_REPORT(?MODULE, OutDir).

mod_archive2_mysql_test_() ->
{
    foreach,
    local,
    fun mysql_tests_setup/0,
    fun common_tests_teardown/1,
    [
        ?test_gen1(mysql_test_read),
        [
            ?test_gen0(mysql_test_insert1),
            ?test_gen0(mysql_test_select1),
            ?test_gen0(mysql_test_select2),
            ?test_gen0(mysql_test_select3),
            ?test_gen0(mysql_test_select4),
            ?test_gen0(mysql_test_select5),
            ?test_gen0(mysql_test_select6),
            ?test_gen0(mysql_test_select7),
            ?test_gen0(mysql_test_select8),
            ?test_gen0(mysql_test_select9),
            ?test_gen0(mysql_test_select10),
            ?test_gen0(mysql_test_select11),
            ?test_gen0(mysql_test_delete1)
        ],
        [
            ?test_gen0(mysql_test_insert1),
            ?test_gen0(mysql_test_update1),
            ?test_gen0(mysql_test_update2),
            ?test_gen0(mysql_test_insert2),
            ?test_gen0(mysql_test_update3),
            ?test_gen0(mysql_test_delete2)
        ]
    ]
}.

mod_archive2_mnesia_test_() ->
{
    foreach,
    local,
    fun mnesia_tests_setup/0,
    fun mnesia_tests_teardown/1,
    [
        ?test_gen1(common_test_read),
        [
            ?test_gen0(common_test_insert1),
            ?test_gen0(common_test_select1),
            ?test_gen0(common_test_select2),
            ?test_gen0(common_test_select3),
            ?test_gen0(common_test_select4),
            ?test_gen0(common_test_select5),
            ?test_gen0(common_test_select6),
            ?test_gen0(common_test_select7),
            ?test_gen0(common_test_select8),
            ?test_gen0(common_test_select9),
            ?test_gen0(common_test_select10),
            ?test_gen0(common_test_select11),
            ?test_gen0(common_test_delete1)
        ],
        [
            ?test_gen0(common_test_insert1),
            ?test_gen0(common_test_update1),
            ?test_gen0(common_test_update2),
            ?test_gen0(common_test_insert2),
            ?test_gen0(common_test_update3),
            ?test_gen0(common_test_delete2)
        ]
    ]
}.

common_tests_setup(RDBMS) ->
    case lists:member(ejabberd_sup, registered()) of
        false -> ejabberd_sup:start_link();
        true -> ok
    end,
    {ok, Pid} =
        mod_archive2_storage:start(
            ?HOST, [{rdbms, RDBMS}, {schema, ?MOD_ARCHIVE2_SCHEMA}]),
    Pid.

common_tests_teardown(_Pid) ->
    mod_archive2_storage:stop(?HOST).

mysql_tests_setup() ->
    common_tests_setup(mysql).

mnesia_tests_setup() ->
    mnesia:start(),
    mnesia:create_schema([node()]),
    mnesia:create_table(archive_message,
                        [{ram_copies, [node()]},
                         {attributes, record_info(fields, archive_message)}]),
    mnesia:create_table(archive_jid_prefs,
                        [{ram_copies, [node()]},
                         {attributes, record_info(fields, archive_jid_prefs)}]),
    common_tests_setup(mnesia).

mnesia_tests_teardown(Pid) ->
    mnesia:clear_table(archive_message),
    mnesia:clear_table(archive_jid_prefs),
    common_tests_teardown(Pid).

-define(RECORD1, #archive_message{utc = {{2000, 12, 31}, {23, 59, 59}},
                                  direction = from,
                                  body = "Hi!",
                                  name = "me"}).

-define(RECORD2, #archive_message{utc = {{1999, 11, 30}, {19, 01, 02}},
                                  direction = from,
                                  body = "Hi there!",
                                  name = "smb"}).

-define(RECORD3, #archive_jid_prefs{us = "test@example.com",
                                    with_user = "juliet",
                                    with_server = "example.com",
                                    save = false,
                                    expire = 3600,
                                    otr = forbid}).

-define(DIRMS,
        ets:fun2ms(
            fun(#archive_message{direction = from} = R) ->
                R
            end)).

% Note: to ensure that we set mock data in the same process we're going to read
% them all calls to ejabberd_odbc:start should be placed in transaction.

mysql_test_read(Pid) ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"insert into archive_message values (null, null, "
                 "'2000-12-31 23:59:59', 0, 'Hi!', 'me')",
                 {updated, 1}},
                {"select LAST_INSERT_ID()", {selected, [], [{1}]}},
                {"select * from archive_message where id = 1",
                 {selected, [], [{1, null, "2000-12-31 23:59:59", "0", "Hi!", "me"}]}},
                {"delete from archive_message where id = 1",
                 {updated, 1}},
                {}])
        end),
    common_test_read(Pid).

common_test_read(_Pid) ->
    {atomic, {deleted, 1}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                {inserted, 1, Key} =
                    mod_archive2_storage:insert([?RECORD1]),
                {selected, [?RECORD1]} =
                    mod_archive2_storage:read(#archive_message{id = Key}),
                {deleted, 1} =
                    mod_archive2_storage:delete(#archive_message{id = Key})
            end).

mysql_test_insert1() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"insert into archive_message values (null, null, "
                 "'2000-12-31 23:59:59', 0, 'Hi!', 'me')",
                 {updated, 1}},
                {"insert into archive_message values (null, null, "
                 "'1999-11-30 19:01:02', 0, 'Hi there!', 'smb')",
                 {updated, 1}},
                {"select LAST_INSERT_ID()", {selected, [], [{2}]}},
                {}])
        end),
    common_test_insert1().

common_test_insert1() ->
    {atomic, {inserted, 2, _Key}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:insert([?RECORD1, ?RECORD2])
            end).

mysql_test_select1() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select * from archive_message where (direction = 0)",
                 {selected, [], [{1, null, "2000-12-31 23:59:59", "0",
                                  "Hi!", "me"},
                                 {2, null, "1999-11-30 19:01:02", "0",
                                  "Hi there!", "smb"}]}},
                {}])
        end),
    common_test_select1().

common_test_select1() ->
        case mod_archive2_storage:transaction(?HOST,
                fun() -> mod_archive2_storage:select(?DIRMS) end) of
            {atomic, {selected, [?RECORD1, ?RECORD2]}} -> ok;
            {atomic, {selected, [?RECORD2, ?RECORD1]}} -> ok;
             _ -> throw({error, badmatch})
        end.

mysql_test_select2() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select * from archive_message where (direction = 0) order by "
                 "name, asc offset 1 limit 2",
                 {selected, [], [{1, null, "1999-11-30 19:01:02", "0",
                                  "Hi there!", "smb"}]}},
                {}])
        end),
    common_test_select2().

common_test_select2() ->
    {atomic, {selected, [?RECORD2]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(?DIRMS,
                    [{order_by, {#archive_message.name, asc}},
                     {offset, 1}, {limit, 2}])
            end).

mysql_test_select3() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select * from archive_message where (direction = 0) order by "
                 "name, desc offset 1 limit 2",
                 {selected, [], [{1, null, "2000-12-31 23:59:59", "0",
                                  "Hi!", "me"}]}},
                {}])
        end),
    common_test_select3().

common_test_select3() ->
    {atomic, {selected, [?RECORD1]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(?DIRMS,
                    [{order_by, {#archive_message.name, desc}},
                     {offset, 1}, {limit, 2}])
            end).

mysql_test_select4() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select count(*) from archive_message where (direction = 0)",
                 {selected, [], [{2}]}},
                {}])
        end),
    common_test_select4().

common_test_select4() ->
    {atomic, {selected, [{2}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(?DIRMS, [{aggregate, count}])
            end).

mysql_test_select5() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select count(*) from archive_message where (direction = 0) "
                 "order by utc, asc limit 1",
                 {selected, [], [{1}]}},
                {}])
        end),
    common_test_select5().

common_test_select5() ->
    {atomic, {selected, [{1}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(?DIRMS,
                    [{aggregate, count},
                     {order_by, {#archive_message.utc, asc}},
                     {limit, 1}])
            end).

mysql_test_select6() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select count(*) from archive_message where (direction = 0) "
                 "order by name, asc offset 1",
                 {selected, [], [{1}]}},
                {}])
        end),
    common_test_select6().

common_test_select6() ->
    {atomic, {selected, [{1}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(?DIRMS,
                    [{order_by, {#archive_message.name, asc}},
                     {offset, 1}, {aggregate, count}])
            end).

mysql_test_select7() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select min(body) from archive_message where (direction = 0) "
                 "order by name, desc limit 1",
                 {selected, [], [{"Hi there!"}]}},
                {}])
        end),
    common_test_select7().

common_test_select7() ->
    {atomic, {selected, [{"Hi there!"}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(?DIRMS,
                    [{order_by, {#archive_message.name, desc}},
                     {limit, 1},
                     {aggregate, {min, #archive_message.body}}])
            end).

mysql_test_select8() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select max(utc) from archive_message where (direction = 0) "
                "order by utc, asc limit 1",
                 {selected, [], [{"1999-11-30 19:01:02"}]}},
                {}])
        end),
    common_test_select8().

common_test_select8() ->
    {atomic, {selected, [{{{1999, 11, 30}, {19, 01, 02}}}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(?DIRMS,
                    [{order_by, {#archive_message.utc, asc}},
                     {limit, 1},
                     {aggregate, {max, #archive_message.utc}}])
            end).

mysql_test_select9() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select body, name from archive_message order by "
                 "name, asc",
                 {selected, [], [{"Hi!", "me"}, {"Hi there!", "smb"}]}},
                {}])
        end),
    common_test_select9().

common_test_select9() ->
    {atomic, {selected, [{"Hi!", "me"}, {"Hi there!", "smb"}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(
                    ets:fun2ms(
                        fun(#archive_message{body = Body, name = Name}) ->
                            {Body, Name}
                        end), [{order_by, {#archive_message.name, asc}}])
            end).

mysql_test_select10() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select body, name from archive_message order by "
                 "name, desc",
                 {selected, [], [{"Hi there!", "smb"}, {"Hi!", "me"}]}},
                {}])
        end),
    common_test_select10().

common_test_select10() ->
    {atomic, {selected, [{"Hi there!", "smb"}, {"Hi!", "me"}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(
                    ets:fun2ms(
                        fun(#archive_message{body = Body, name = Name}) ->
                            {Body, Name}
                        end), [{order_by, {#archive_message.name, desc}}])
            end).

mysql_test_select11() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select body, name from archive_message where (name = 'me')",
                 {selected, [], [{"Hi!", "me"}]}},
                {}])
        end),
    common_test_select11().

common_test_select11() ->
    {atomic, {selected, [{"Hi!", "me"}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:select(
                    ets:fun2ms(
                        fun(#archive_message{body = Body, name = Name})
                            when Name =:= "me" ->
                            {Body, Name}
                        end))
            end).

mysql_test_delete1() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"delete from archive_message where (direction = 0)",
                 {updated, 2}},
                {}])
        end),
    common_test_delete1().

common_test_delete1() ->
    {atomic, {deleted, 2}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:delete(?DIRMS)
            end).


mysql_test_update1() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"select * from archive_message where (name = 'me')",
                 {selected, [], [{1, null, "2000-12-31 23:59:59", "0",
                                  "Hi!", "me"}]}},
                {"update archive_message set name = 'other' where id = 1",
                 {updated, 1}},
                {}])
        end),
    common_test_update1().

common_test_update1() ->
    {atomic, {updated, 1}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                {selected, [Record]} =
                    mod_archive2_storage:select(
                        ets:fun2ms(fun(#archive_message{name = "me"} = R) ->
                                        R
                                   end)),
                ?RECORD1 = Record,
                {updated, 1} =
                    mod_archive2_storage:update(
                        #archive_message{id = Record#archive_message.id,
                                         name = "other"})
            end).

mysql_test_update2() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"update archive_message set direction = 1 where (direction = 0)",
                 {updated, 2}},
                {"select direction, name from archive_message order by "
                 "name, asc",
                 {selected, [], [{"1", "other"}, {"1", "smb"}]}},
                {}])
        end),
    common_test_update2().

common_test_update2() ->
    {atomic, {selected, [{to, "other"}, {to, "smb"}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                {updated, 2} =
                    mod_archive2_storage:update(
                        #archive_message{direction = to},
                        ets:fun2ms(
                            fun(#archive_message{direction = from} = R) ->
                                R
                            end)),
                mod_archive2_storage:select(
                    ets:fun2ms(
                        fun(#archive_message{name = Name, direction = Dir}) ->
                            {Dir, Name}
                        end), [{order_by, {#archive_message.name, asc}}])
            end).

mysql_test_insert2() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"insert into archive_jid_prefs values ('test@example.com', "
                 "'juliet', 'example.com', null, 0, 3600, 2)",
                 {updated, 1}},
                {"select LAST_INSERT_ID()", {selected, [], [{"0"}]}},
                {}])
        end),
    common_test_insert2().

common_test_insert2() ->
    {atomic, {inserted, 1, _Key}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:insert([?RECORD3])
            end).

mysql_test_update3() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"update archive_jid_prefs set save = 1, otr = 4",
                 {updated, 1}},
                {"select save, otr from archive_jid_prefs "
                 "where (with_user = 'juliet')",
                 {selected, [], [{"1", "4"}]}},
                {}])
        end),
    common_test_update3().

common_test_update3() ->
    {atomic, {selected, [{true, prefer}]}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                {updated, 1} =
                    mod_archive2_storage:update(
                        #archive_jid_prefs{save = true, otr = prefer},
                        ets:fun2ms(
                            fun(#archive_jid_prefs{} = R) ->
                                R
                            end)),
                mod_archive2_storage:select(
                    ets:fun2ms(
                        fun(#archive_jid_prefs{with_user = "juliet",
                                               save = Save, otr = OTR}) ->
                            {Save, OTR}
                        end))
            end).

mysql_test_delete2() ->
    mod_archive2_storage:transaction(?HOST,
        fun() ->
            ejabberd_odbc:start([
                {},
                {"delete from archive_message",
                 {updated, 2}},
                {}])
        end),
    common_test_delete2().

common_test_delete2() ->
    {atomic, {deleted, 2}} =
        mod_archive2_storage:transaction(?HOST,
            fun() ->
                mod_archive2_storage:delete(
                    ets:fun2ms(fun(#archive_message{} = R) -> R end))
            end).
