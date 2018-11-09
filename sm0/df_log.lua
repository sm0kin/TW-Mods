--Log script to text
--v function(text: string | number | boolean | CA_CQI)
    local function ERRORLOG(text)
        if not __write_output_to_logfile then
            return;
        end
    
        local logText = tostring(text)
        local logTimeStamp = os.date("%d, %m %Y %X")
        local popLog = io.open("lua_runtime_errors.txt","a")
        --# assume logTimeStamp: string
        popLog :write("ERR:  [".. logTimeStamp .. "]:  "..logText .. "  \n")
        popLog :flush()
        popLog :close()
    end
    
    --v function(func: function) --> any
    function safeCall(func)
        local status, result = pcall(func)
        if not status then
          ERRORLOG("ERROR")
          ERRORLOG(tostring(result))
          ERRORLOG(debug.traceback());
        end
        return result;
    end
    
    
    --v [NO_CHECK] function(...: any)
    function pack2(...) return {n=select('#', ...), ...} end
    --v [NO_CHECK] function(t: vector<WHATEVER>) --> vector<WHATEVER>
    function unpack2(t) return unpack(t, 1, t.n) end
    
    --v [NO_CHECK] function(f: function(), argProcessor: function()) --> function()
    function wrapFunction(f, argProcessor)
        return function(...)
            local someArguments = pack2(...);
            if argProcessor then
                safeCall(function() argProcessor(someArguments) end)
            end
            local result = pack2(safeCall(function() return f(unpack2( someArguments )) end));
            return unpack2(result);
            end
    end
    
    core.trigger_event = wrapFunction(
        core.trigger_event,
        function(ab)
        end
    );
    
    cm.check_callbacks = wrapFunction(
        cm.check_callbacks,
        function(ab)
        end
    )
    
    local currentAddListener = core.add_listener;
    --v [NO_CHECK] function(core: any, listenerName: any, eventName: any, conditionFunc: any, listenerFunc: any, persistent: any)
    function myAddListener(core, listenerName, eventName, conditionFunc, listenerFunc, persistent)
        local wrappedCondition = nil;
        if is_function(conditionFunc) then
            wrappedCondition =  wrapFunction(conditionFunc);
        else
            wrappedCondition = conditionFunc;
        end
        currentAddListener(
            core, listenerName, eventName, wrappedCondition, wrapFunction(listenerFunc), persistent
        )
    end
    core.add_listener = myAddListener;