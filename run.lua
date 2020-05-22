serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_MasTer = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_MasTer = function() 
local Create_Info = function(Token,Sudo,UserName)  
local MasTer_Info_Sudo = io.open("sudo.lua", 'w')
MasTer_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

]])
MasTer_Info_Sudo:close()
end  
if not database:get(Server_MasTer.."Token_MasTer") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_MasTer.."Token_MasTer",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_MasTer.."Id_MasTer") then
print("\27[1;34m\n»» Send Your id Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
io.write('\n\27[1;31m»» The id Is Saved\n\27[0;39;49m')
database:set(Server_MasTer.."Id_MasTer",UserName)
else
io.write('\n\27[1;31mThe id was not Saved\n\27[0;39;49m')
end 
os.execute('lua run.lua')
end
local function Files_MasTer_Info()
Create_Info(database:get(Server_MasTer.."Token_MasTer"),database:get(Server_MasTer.."Id_MasTer"),database:get(Server_MasTer.."UserName_MasTer"))   
local RunMasTer = io.open("MasTer", 'w')
RunMasTer:write([[
#!/usr/bin/env bash
cd $HOME/MasTer
token="]]..database:get(Server_MasTer.."Token_MasTer")..[["
while(true) do
rm -fr ../.telegram-cli
./tg -s ./MasTer.lua -p PROFILE --bot=$token
done
]])
RunMasTer:close()
local RunTs = io.open("tk", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/MasTer
while(true) do
rm -fr ../.telegram-cli
screen -S MasTer -X kill
screen -S MasTer ./MasTer
done
]])
RunTs:close()
end
Files_MasTer_Info()
database:del(Server_MasTer.."Token_MasTer");database:del(Server_MasTer.."Id_MasTer");database:del(Server_MasTer.."UserName_MasTer")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_MasTer()  
var = true
else   
f:close()  
database:del(Server_MasTer.."Token_MasTer");database:del(Server_MasTer.."Id_MasTer");database:del(Server_MasTer.."UserName_MasTer")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
var = false
end  
return var
end
Load_File()
