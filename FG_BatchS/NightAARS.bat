set /p ap=Airport:
set /p ac=Aircraft:
set /p rw=Runway:

"C:\FlightGear 2017.2.1\bin\fgfs.exe" --fg-root="C:\FlightGear 2017.2.1\data" ^
--timeofday=midnight ^
--airport=%ap% ^
--aircraft=%ac% ^
--runway=%rw% ^
--language=en ^
--geometry=800x600 ^
--disable-ai-models ^
--disable-ai-traffic ^
--disable-terrasync ^
--disable-hud-3d ^
--visibility-miles=30 




