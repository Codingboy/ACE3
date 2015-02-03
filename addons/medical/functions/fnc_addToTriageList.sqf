/**
 * fn_addToTriageList.sqf
 * @Descr: N/A
 * @Author: Glowbal
 *
 * @Arguments: []
 * @Return:
 * @PublicAPI: false
 */

#include "script_component.hpp"

private ["_unit","_caller","_newItem","_log", "_inList","_amount"];
_unit = _this select 0;
_newItem = _this select 1;

if (!local _unit) exitwith {
    [_this, QUOTE(FUNC(addToTriageList)), _unit] call EFUNC(common,execRemoteFnc);
};

_log = [_unit,QGVAR(triageCard)] call EFUNC(common,getDefinedVariable);
_inList = false;
_amount = 1;
{
    if ((_x select 0) == _newItem) exitwith {
        private "_info";
        _info = _log select _foreachIndex;
        _info set [1,(_info select 1) + 1];
        _log set [_foreachIndex, _info];

        _amount = (_info select 1);
        _inList = true;
    };
}foreach _log;

if (!_inList) then {
    _log pushback [_newItem,1];
};

[_unit,QGVAR(triageCard),_log] call EFUNC(common,setDefinedVariable);
["Medical_onItemAddedToTriageCard", [_unit, _newItem, _amount]] call ace_common_fnc_localEvent;