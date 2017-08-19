set /p ap=Airport:

"C:\FlightGear 2017.2.1\bin\fgfs.exe" --fg-root="C:\FlightGear 2017.2.1\data" ^
--airport=%ap% ^
--timeofday=morning ^
--language=en ^
--aircraft=warriorII-160 ^
--geometry=800x600 ^
--wind=359:291@0:0 ^
--disable-ai-models ^
--disable-ai-traffic ^
--disable-terrasync
--disable-hud-3d ^
--visibility-miles=25 
 