# Basic KartingJob for QBCore

<a href="https://youtu.be/NOAljX6BezE">Preview</a>

### Dependencies
 
 * <a href="https://github.com/qbcore-framework/qb-target">qb-target</a>

 * <a href="https://github.com/qbcore-framework/qb-menu">qb-menu</a>
 
 * <a href="https://github.com/qbcore-framework/LegacyFuel">LegacyFuel</a>


 Add This To qb-core > shared > jobs.lua
```
['karting'] = {
    label = 'Karting',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Karting Worker',
            payment = 5
        },
        ['1'] = {
            name = 'Karting Boss',
            payment = 10,
            isboss = true
        },
    },
},
```

Go to qb-managment cl_config.lua file and add this 
```
    ['karting'] = {
        { coords = vector3(-159.17, -2128.2, 16.72), length = 1.75, width = 0.5, heading = 290.0, minZ = 16.0, maxZ = 17.0 },
    },
```
inside of Config.BossMenuZones = { 

and execute or import this into your database
```
INSERT INTO `management_funds` (`job_name`, `amount`, `type`) VALUES
('karting', 1000, 'boss');
```

Map: https://forum.cfx.re/uploads/short-url/mG2RdkXTckktnR0wJAcfaFiKY4v.rar
