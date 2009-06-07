@ECHO ON

set BUILD_DIR=build
set APPNAME=DLApplet

call sample_setenv.bat
call setenv.bat

call %JYTHON_HOME%\jython.bat setup.py clean

mkdir %BUILD_DIR%

echo Repackaging jython with only needed classes
mkdir %BUILD_DIR%\jython
cd %BUILD_DIR%\jython
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar com/sun
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/antlr
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/compiler
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/constantine
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/core
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/expose
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/modules
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/objectweb
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/posix
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/util
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/Version.class
%JAVA_HOME%\bin\jar.exe xvf %JYTHON_HOME%\jython.jar org/python/version.properties

%JAVA_HOME%\bin\jar.exe cvf jython.jar *
move jython.jar ..\.
cd ..
rmdir /S /Q jython
cd ..

pause

cd jyinterface
%JAVA_HOME%\bin\javac.exe -Xlint:unchecked -classpath %JYTHON_HOME%\jython.jar Download.java Downloader.java JythonFactory.java ProgressRenderer.java DownloadTableModel.java DownloadManager.java DLApplet.java
mkdir ..\%BUILD_DIR%\jyinterface
move *.class ..\%BUILD_DIR%\jyinterface
cd ..

REM copy %JYTHON_HOME%\Lib\* %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\urllib2.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\thread.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\socket.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\os.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\md5.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\sha.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\re.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\math.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\time.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\urlparse.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\hashlib.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\locale.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\threading.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\ftplib.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\httplib.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\base64.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\sys.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\gettext.py %BUILD_DIR%\.

copy %JYTHON_HOME%\Lib\string.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\sre_compile.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\sre_constants.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\sre_parse.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\copy_reg.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\types.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\weakref.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\UserDict.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\traceback.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\linecache.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\stat.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\ntpath.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\atexit.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\mimetools.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\rfc822.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\tempfile.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\random.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\warnings.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\posixpath.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\bisect.py %BUILD_DIR%\.
copy %JYTHON_HOME%\Lib\urllib.py %BUILD_DIR%\.

xcopy /S /I %JYTHON_HOME%\Lib\xml %BUILD_DIR%\xml
xcopy /S /I %JYTHON_HOME%\Lib\encodings %BUILD_DIR%\encodings

copy JDownload.py %BUILD_DIR%\.
copy JDownloader.py %BUILD_DIR%\.
copy download.py %BUILD_DIR%\.
copy xmlutils.py %BUILD_DIR%\.

cd %BUILD_DIR%
echo Class-Path: jython.jar > manifest.txt
%JAVA_HOME%\bin\jar.exe cvfme %APPNAME%.jar manifest.txt jyinterface.DownloadManager jyinterface xml/*.py xml/parsers/*.py encodings/*.py *.py

REM %JAVA_HOME%\bin\java.exe -jar applet.jar

%JAVA_HOME%\bin\jarsigner.exe %APPNAME%.jar %APPNAME%

cd ..

pause
