%%--------------------------------------------------------------------
%% Copyright (c) 2020-2023 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(emqx_psk_app).

-behaviour(application).

-export([
    start/2,
    stop/1
]).

-include("emqx_psk.hrl").

start(_Type, _Args) ->
    ok = mria:wait_for_tables(emqx_psk:create_tables()),
    emqx_conf:add_handler([?PSK_KEY], emqx_psk),
    {ok, Sup} = emqx_psk_sup:start_link(),
    {ok, Sup}.

stop(_State) ->
    ok.
