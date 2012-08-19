-define(MGMT_TC1_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,
            ?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[],[]},
            undefined,undefined,'jabber:client'}}).

-define(MGMT_TC2_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[],
                [{xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,<<"juliet@capulet.com/chamber">>},
                      {xmlattr,undefined,<<"start">>,<<"1469-07-21T02:56:15.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,<<"benvolio@montague.net">>},
                      {xmlattr,undefined,<<"start">>,<<"1469-07-21T03:01:54.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,<<"balcony@house.capulet.com">>},
                      {xmlattr,undefined,<<"start">>,<<"1469-07-21T03:16:37.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                     [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                          [{xmlattr,undefined,<<"index">>,<<"0">>}],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],last,[],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],count,[],
                          [{xmlcdata,<<"3">>}]}]}]},
            undefined,undefined,'jabber:client'}}).

-define(MGMT_TC3_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[],
                [{xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,
                          <<"juliet@capulet.com/chamber">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T02:56:15.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                     [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                          [{xmlattr,undefined,<<"index">>,<<"0">>}],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],last,[],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],count,
                          [],
                          [{xmlcdata,<<"3">>}]}]}]},
            undefined,undefined,'jabber:client'}}).

-define(MGMT_TC4_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[],
                [{xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,<<"benvolio@montague.net">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T03:01:54.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                     [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                          [{xmlattr,undefined,<<"index">>,<<"1">>}],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],last,[],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],count,
                          [],
                          [{xmlcdata,<<"3">>}]}]}]},
            undefined,undefined,'jabber:client'}}).

-define(MGMT_TC5_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[],
                [{xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,<<"benvolio@montague.net">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T03:01:54.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,
                          <<"balcony@house.capulet.com">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T03:16:37.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                     [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                          [{xmlattr,undefined,<<"index">>,<<"1">>}],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],last,[],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],count,
                          [],
                          [{xmlcdata,<<"3">>}]}]}]},
            undefined,undefined,'jabber:client'}}).

-define(MGMT_TC6_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[],
                [{xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,
                          <<"juliet@capulet.com/chamber">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T02:56:15.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,<<"benvolio@montague.net">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T03:01:54.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                     [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                          [{xmlattr,undefined,<<"index">>,<<"0">>}],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],last,[],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],count,
                          [],
                          [{xmlcdata,<<"3">>}]}]}]},
            undefined,undefined,'jabber:client'}}).
  
-define(MGMT_TC7_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[],
                [{xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,<<"benvolio@montague.net">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T03:01:54.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                     [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                          [{xmlattr,undefined,<<"index">>,<<"0">>}],
                          [{xmlcdata,_}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],last,[],
                          [{xmlcdata,_}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],count,
                          [],
                          [{xmlcdata,<<"1">>}]}]}]},
            undefined,undefined,'jabber:client'}}).

-define(MGMT_TC8_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[],
                [{xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,
                          <<"juliet@capulet.com/chamber">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T02:56:15.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                     [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                          [{xmlattr,undefined,<<"index">>,<<"0">>}],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],last,[],
                          [{xmlcdata,
                               _}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],count,
                          [],
                          [{xmlcdata,<<"1">>}]}]}]},
            undefined,undefined,'jabber:client'}}).

-define(MGMT_TC9_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[], []},
            undefined,undefined,'jabber:client'}}).

-define(MGMT_TC10_RETRIEVE_RESULT,
    {atomic,
        {iq,response,result,<<"stanza-",_/binary>>,
            ?NS_ARCHIVING,
            {xmlel,?NS_ARCHIVING,[],list,[],
                [{xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,
                          <<"benvolio@montague.net">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T03:01:54.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,undefined,[],chat,
                     [{xmlattr,undefined,<<"with">>,
                          <<"balcony@house.capulet.com">>},
                      {xmlattr,undefined,<<"start">>,
                          <<"1469-07-21T03:16:37.000000Z">>},
                      {xmlattr,undefined,<<"version">>,<<"1">>}],
                     []},
                 {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                     [{xmlel,'http://jabber.org/protocol/rsm',[],
                          first,
                          [{xmlattr,undefined,<<"index">>,<<"0">>}],
                          [{xmlcdata,_}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],
                          last,[],
                          [{xmlcdata,_}]},
                      {xmlel,'http://jabber.org/protocol/rsm',[],
                          count,[],
                          [{xmlcdata,<<"2">>}]}]}]},
            undefined,undefined,'jabber:client'}}).

-define(MGMT_TC12_RETRIEVE_RESULT,
    {atomic,{iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
        {xmlel,?NS_ARCHIVING,[],list,[],
               [{xmlel,undefined,[],chat,
                       [{xmlattr,undefined,<<"with">>,
                                 <<"balcony@house.capulet.com">>},
                        {xmlattr,undefined,<<"start">>,
                                 <<"1469-07-21T03:16:37.000000Z">>},
                        {xmlattr,undefined,<<"version">>,<<"1">>}],
                       []},
                {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                       [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                               [{xmlattr,undefined,<<"index">>,<<"0">>}],
                               [{xmlcdata,_}]},
                        {xmlel,'http://jabber.org/protocol/rsm',[],last,
                               [],
                               [{xmlcdata,_}]},
                        {xmlel,'http://jabber.org/protocol/rsm',[],count,
                               [],
                               [{xmlcdata,<<"1">>}]}]}]},
        undefined,undefined,'jabber:client'}}).

-define(MGMT_TC13_RETRIEVE_RESULT,
{atomic,
    {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
        {xmlel,?NS_ARCHIVING,[],modified,[],
            [{xmlel,undefined,[],changed,
                 [{xmlattr,undefined,<<"with">>,<<"benvolio@montague.net">>},
                  {xmlattr,undefined,<<"start">>,<<"1469-07-21T03:01:54.000000Z">>},
                  {xmlattr,undefined,<<"version">>,<<"1">>}],
                 []},
             {xmlel,undefined,[],changed,
                 [{xmlattr,undefined,<<"with">>,<<"balcony@house.capulet.com">>},
                  {xmlattr,undefined,<<"start">>,<<"1469-07-21T03:16:37.000000Z">>},
                  {xmlattr,undefined,<<"version">>,<<"1">>}],
                 []},
             {xmlel,undefined,[],changed,
                 [{xmlattr,undefined,<<"with">>,<<"juliet@capulet.com/chamber">>},
                  {xmlattr,undefined,<<"start">>,<<"1469-07-21T02:56:15.000000Z">>},
                  {xmlattr,undefined,<<"version">>,<<"1">>}],
                 []},
             {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                 [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                      [{xmlattr,undefined,<<"index">>,<<"0">>}],
                      [{xmlcdata,
                           _}]},
                  {xmlel,'http://jabber.org/protocol/rsm',[],last,[],
                      [{xmlcdata,
                           _}]},
                  {xmlel,'http://jabber.org/protocol/rsm',[],count,[],
                      [{xmlcdata,<<"3">>}]}]}]},
        undefined,undefined,'jabber:client'}}).

-define(MGMT_TC14_RETRIEVE_RESULT,
{atomic,
    {iq,response,result,<<"stanza-",_/binary>>,?NS_ARCHIVING,
        {xmlel,?NS_ARCHIVING,[],modified,[],
            [{xmlel,undefined,[],changed,
                 [{xmlattr,undefined,<<"with">>,<<"balcony@house.capulet.com">>},
                  {xmlattr,undefined,<<"start">>,<<"1469-07-21T03:16:37.000000Z">>},
                  {xmlattr,undefined,<<"version">>,<<"1">>}],
                 []},
             {xmlel,undefined,[],removed,
                 [{xmlattr,undefined,<<"with">>,<<"juliet@capulet.com/chamber">>},
                  {xmlattr,undefined,<<"start">>,<<"1469-07-21T02:56:15.000000Z">>},
                  {xmlattr,undefined,<<"version">>,<<"1">>}],
                 []},
             {xmlel,'http://jabber.org/protocol/rsm',[],set,[],
                 [{xmlel,'http://jabber.org/protocol/rsm',[],first,
                      [{xmlattr,undefined,<<"index">>,<<"0">>}],
                      [{xmlcdata,
                           _}]},
                  {xmlel,'http://jabber.org/protocol/rsm',[],last,[],
                      [{xmlcdata,
                           _}]},
                  {xmlel,'http://jabber.org/protocol/rsm',[],count,[],
                      [{xmlcdata,<<"2">>}]}]}]},
        undefined,undefined,'jabber:client'}}).
