set /p ac=Aircraft:

"C:\FlightGear 2017.2.1\bin\fgfs.exe" --fg-root="C:\FlightGear 2017.2.1\data" ^
--timeofday=morning ^
--language=en ^
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
--wind=359:291@0:0 ^
--enable-auto-coordination ^
--httpd=8080 ^
--disable-ai-models ^
--disable-ai-traffic ^
--disable-hud-3d ^
--visibility-miles=20 ^
--enable-freeze 




