<script language="javascript" type="text/javascript" runat="server">
var hexcase = 0;
var b64pad= "=";
var chrsz = 8;
function hex_sha1(s){return binb2hex(core_sha1(str2binb(s),s.length * chrsz));}
function b64_sha1(s){return binb2b64(core_sha1(str2binb(s),s.length * chrsz));}
function str_sha1(s){return binb2str(core_sha1(str2binb(s),s.length * chrsz));}
function hex_hmac_sha1(key, data){ return binb2hex(core_hmac_sha1(key, data));}
function b64_hmac_sha1(key, data){ return binb2b64(core_hmac_sha1(key, data));}
function str_hmac_sha1(key, data){ return binb2str(core_hmac_sha1(key, data));}
function sha1_vm_test()
{
return hex_sha1("abc") == "a9993e364706816aba3e25717850c26c9cd0d89d";
}
function core_sha1(x, len)
{
x[len >> 5] |= 0x80 << (24 - len % 32);
x[((len + 64 >> 9) << 4) + 15] = len;
var w = Array(80);
var a =1732584193;
var b = -271733879;
var c = -1732584194;
var d =271733878;
var e = -1009589776;
for(var i = 0; i < x.length; i += 16)
{
var olda = a;
var oldb = b;
var oldc = c;
var oldd = d;
var olde = e;
for(var j = 0; j < 80; j++)
{
if(j < 16) w[j] = x[i + j];
else w[j] = rol(w[j-3] ^ w[j-8] ^ w[j-14] ^ w[j-16], 1);
var t = safe_add(safe_add(rol(a, 5), sha1_ft(j, b, c, d)),
 safe_add(safe_add(e, w[j]), sha1_kt(j)));
e = d;
d = c;
c = rol(b, 30);
b = a;
a = t;
}
a = safe_add(a, olda);
b = safe_add(b, oldb);
c = safe_add(c, oldc);
d = safe_add(d, oldd);
e = safe_add(e, olde);
}
return Array(a, b, c, d, e);
}
function sha1_ft(t, b, c, d)
{
if(t < 20) return (b & c) | ((~b) & d);
if(t < 40) return b ^ c ^ d;
if(t < 60) return (b & c) | (b & d) | (c & d);
return b ^ c ^ d;
}
function sha1_kt(t)
{
return (t < 20) ?1518500249 : (t < 40) ?1859775393 :
(t < 60) ? -1894007588 : -899497514;
}
function core_hmac_sha1(key, data)
{
var bkey = str2binb(key);
if(bkey.length > 16) bkey = core_sha1(bkey, key.length * chrsz);
var ipad = Array(16), opad = Array(16);
for(var i = 0; i < 16; i++)
{
ipad[i] = bkey[i] ^ 0x36363636;
opad[i] = bkey[i] ^ 0x5C5C5C5C;
}
var hash = core_sha1(ipad.concat(str2binb(data)), 512 + data.length * chrsz);
return core_sha1(opad.concat(hash), 512 + 160);
}
function safe_add(x, y)
{
var lsw = (x & 0xFFFF) + (y & 0xFFFF);
var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
return (msw << 16) | (lsw & 0xFFFF);
}
function rol(num, cnt)
{
return (num << cnt) | (num >>> (32 - cnt));
}
function str2binb(str)
{
var bin = Array();
var mask = (1 << chrsz) - 1;
for(var i = 0; i < str.length * chrsz; i += chrsz)
bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (32 - chrsz - i%32);
return bin;
}
function binb2str(bin)
{
var str = "";
var mask = (1 << chrsz) - 1;
for(var i = 0; i < bin.length * 32; i += chrsz)
str += String.fromCharCode((bin[i>>5] >>> (32 - chrsz - i%32)) & mask);
return str;
}
function binb2hex(binarray)
{
var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
var str = "";
for(var i = 0; i < binarray.length * 4; i++)
{
str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
 hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8)) & 0xF);
}
return str;
}
function binb2b64(binarray)
{
var tab = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
var str = "";
for(var i = 0; i < binarray.length * 4; i += 3)
{
var triplet = (((binarray[i >> 2] >> 8 * (3 -i %4)) & 0xFF) << 16)
| (((binarray[i+1 >> 2] >> 8 * (3 - (i+1)%4)) & 0xFF) << 8 )
|((binarray[i+2 >> 2] >> 8 * (3 - (i+2)%4)) & 0xFF);
for(var j = 0; j < 4; j++)
{
if(i * 8 + j * 6 > binarray.length * 32) str += b64pad;
else str += tab.charAt((triplet >> 6*(3-j)) & 0x3F);
}
}
return str;
}
</script>
<%
Function TurkceTemizle(TurkceVeri)
	If TurkceVeri<>"" Then	
		TRHarf1 = Array("Ğ","ğ","Ü","ü","Ş","ş","İ","ı","Ö","ö","Ç","ç") 
		TRHarf2 = Array("G","g","U","u","S","s","I","i","O","o","C","c")
		For TRHarfx = 0 To Ubound(TRHarf1) 
		TurkceVeri = Replace(TurkceVeri,TRHarf1(TRHarfx),TRHarf2(TRHarfx)) 
		Next
		AsciiKarakterler = "/,*,-,\,(,),%,+,^,#,!,',[,],{,},?,&,$,<,>,|,`,;,~,‘,’,¡,¢,£,¤,¥,¦,§,¨,©,ª,«,»,¬,­,®,¯,°,±,²,³,´,µ,¶,·,¸,¹,º,¼,½,¾,¿,À,Á,Â,Ã,Ä,Å,Æ,È,É,Ê,Ë,Ì,Í,Î,Ï,Ñ,Ò,Ó,Ô,Õ,×,Ø,Ù,Ú,Û,İ,ß,à,á,â,ã,ä,å,æ,è,é,ê,ë,ì,í,î,ï,ñ,ò,ó,ô,õ,÷,ø,ù,ú,û,ı,ÿ"
		AsciiKarakter =  Split(AsciiKarakterler, "," ) 
		For  i = 0 to  Ubound(AsciiKarakter) 
		TurkceVeri =  Replace(TurkceVeri, AsciiKarakter(i), " ")  
		Next
		TurkceTemizle=TurkceVeri
	End if
End Function
' --------------------------------------------------------------------------------------------
Function JsonURL(URLadres)
	If URLadres<>"" Then
		URLadres = Replace(URLadres,"/","\/")
		JsonURL  = URLadres
	End If
End Function
' --------------------------------------------------------------------------------------------
Private Function statusNedir(Kaynak)
	Baslangic = InStr(1,Kaynak, "status:" , 1) + Len("status:" )
	Genislik = InStr(Baslangic,Kaynak, "," , 1) - Baslangic 
	statusNedir = Mid(Kaynak, Baslangic, Genislik)
End Function
' --------------------------------------------------------------------------------------------
Private Function mesajNedir(Kaynak)
	Baslangic = InStr(1,Kaynak, "errorMessage:" , 1) + Len("errorMessage:" )
	Genislik = InStr(Baslangic,Kaynak, "," , 1) - Baslangic
	mesajNedir = Mid(Kaynak, Baslangic, Genislik)
End Function
' --------------------------------------------------------------------------------------------
Private Function There3DNedir(Kaynak)
	Baslangic = InStr(1,Kaynak, "threeDSHtmlContent:" , 1) + Len("threeDSHtmlContent:" )
	Genislik = InStr(Baslangic,Kaynak, "}" , 1) - Baslangic
	There3DNedir = Mid(Kaynak, Baslangic, Genislik)
End Function
' --------------------------------------------------------------------------------------------
Function IPAdres
	If request.servervariables("HTTP_VIA") <> "" Then
		IPAdres = request.servervariables("HTTP_X_FORWARDED_FOR")
	Else
		IPAdres = request.servervariables("REMOTE_ADDR")
	End If
End Function
' --------------------------------------------------------------------------------------------
Base64Chars =	"ABCDEFGHIJKLMNOPQRSTUVWXYZ" & _
		"abcdefghijklmnopqrstuvwxyz" & _
		"0123456789" & _
		"+/"
Public Function base64_encode( byVal strIn )
	Dim c1, c2, c3, w1, w2, w3, w4, n, strOut
	For n = 1 To Len( strIn ) Step 3
		c1 = Asc( Mid( strIn, n, 1 ) )
		c2 = Asc( Mid( strIn, n + 1, 1 ) + Chr(0) )
		c3 = Asc( Mid( strIn, n + 2, 1 ) + Chr(0) )
		w1 = Int( c1 / 4 ) : w2 = ( c1 And 3 ) * 16 + Int( c2 / 16 )
		If Len( strIn ) >= n + 1 Then 
			w3 = ( c2 And 15 ) * 4 + Int( c3 / 64 ) 
		Else 
			w3 = -1
		End If
		If Len( strIn ) >= n + 2 Then 
			w4 = c3 And 63 
		Else 
			w4 = -1
		End If
		strOut = strOut + mimeencode( w1 ) + mimeencode( w2 ) + _
				  mimeencode( w3 ) + mimeencode( w4 )
	Next
	base64_encode = strOut
End Function
Private Function mimeencode( byVal intIn )
	If intIn >= 0 Then 
		mimeencode = Mid( Base64Chars, intIn + 1, 1 ) 
	Else 
		mimeencode = ""
	End If
End Function
Public Function base64_decode( byVal strIn )
	Dim w1, w2, w3, w4, n, strOut
	For n = 1 To Len( strIn ) Step 4
		w1 = mimedecode( Mid( strIn, n, 1 ) )
		w2 = mimedecode( Mid( strIn, n + 1, 1 ) )
		w3 = mimedecode( Mid( strIn, n + 2, 1 ) )
		w4 = mimedecode( Mid( strIn, n + 3, 1 ) )
		If w2 >= 0 Then _
			strOut = strOut + _
				Chr( ( ( w1 * 4 + Int( w2 / 16 ) ) And 255 ) )
		If w3 >= 0 Then _
			strOut = strOut + _
				Chr( ( ( w2 * 16 + Int( w3 / 4 ) ) And 255 ) )
		If w4 >= 0 Then _
			strOut = strOut + _
				Chr( ( ( w3 * 64 + w4 ) And 255 ) )
	Next
	base64_decode = strOut
End Function
Private Function mimedecode( byVal strIn )
	If Len( strIn ) = 0 Then 
		mimedecode = -1 : Exit Function
	Else
		mimedecode = InStr( Base64Chars, strIn ) - 1
	End If
End Function
%>
