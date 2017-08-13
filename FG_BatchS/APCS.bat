set /p ac=Aircraft:

"C:\FlightGear 2017.2.1\bin\fgfs.exe" --fg-root="C:\FlightGear 2017.2.1\data" ^
--timeofday=morning ^
--language=en ^
<<<<<<< HEAD:FG_BatchS/APCS.bat
--aircraft=%ac% ^
--in-air ^
--prop:/controls/engines/engine/throttle=0.7 ^
--altitude=2500 ^
--geometry=800x600 ^
--heading=336 ^
--offset-azimuth=316 ^
--nav1=320:110.3 ^
--ndb=YRR ^
--dme=nav1 ^
--adf=377 ^
--offset-distance=12 ^
--vc=110 ^
=======
--aircraft=pa28-161 ^
--altitude=3000 ^
--heading=263 ^
--vc=120 ^
--prop:/controls/engines/engine/throttle=0.9 ^
--airport=ymml ^
--runway=27 ^
--offset-distance=15 ^
--geometry=800x600 ^
>>>>>>> 53b9743... more doco and commandline:FG_BatchS/ALPV.bat
--wind=359:291@0:0 ^
--enable-auto-coordination ^
--httpd=8080 ^
--disable-ai-models ^
--disable-ai-traffic ^
--disable-hud-3d ^
<<<<<<< HEAD:FG_BatchS/APCS.bat
--visibility-miles=20 ^
--enable-freeze 
=======
--disable-terrasync ^
--visibility-miles=30 ^
--enable-freeze

>>>>>>> 53b9743... more doco and commandline:FG_BatchS/ALPV.bat




