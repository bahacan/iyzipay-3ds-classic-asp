<!--#include file="function.asp"-->
<%
' --------------------------------------------------
ApiKey            = "q7W8LoLWOqVxKIEb5555u6CrOjtOg9o8"
SecretKey         = "6VeIklYLyGjAPvmkUwyf55558meeHXlm"
' --------------------------------------------------
RandomString      = Request.Form("conversationId")
PaymentID         = Request.Form("paymentId")
ConversationData  = Request.Form("conversationData")
Status            = Request.Form("status")
' --------------------------------------------------

if Status<>"" then

	if Status="" or Status="failure" then
		response.write "3D Onayı Alınamadı"
		response.end()
	else

		PKINedir = "[locale=tr,conversationId="&RandomString&",paymentId="&PaymentID&",conversationData="&ConversationData&"]"
		JSONedir = "{""locale"":""tr"",""conversationId"":"""&RandomString&""",""paymentId"":"""&PaymentID&""",""conversationData"":"""&ConversationData&"""}"

		xHasholustur = ""
		xHasholustur = xHasholustur & ApiKey
		xHasholustur = xHasholustur & RandomString
		xHasholustur = xHasholustur & SecretKey
		xHasholustur = xHasholustur & PKINedir

		xHashB64=b64_sha1(xHasholustur)
		
			set xml = CreateObject("MSXML2.XMLHTTP.3.0")
			xml.open "POST", "https://api.iyzipay.com/payment/iyzipos/auth3ds/ecom", false
			xml.setRequestHeader "Accept", "application/json"
			xml.setRequestHeader "Authorization", "IYZWS "&ApiKey&":"&xHashB64&""
			xml.setRequestHeader "x-iyzi-rnd", ""&RandomString&""
			xml.setRequestHeader "Content-Type", "application/json"
			xml.Send JSONedir
			Donus=xml.responseText
			
				if Donus<>"" then
				Donus=replace(Donus,"""","")
				sonucKodu = statusNedir(Donus)
					if sonucKodu = "success" then
					There3D=There3DNedir(Donus)
						response.write "Ödeme Başarılı"
						response.end()
					else
						gelenMesaj = mesajNedir(Donus)
						response.write gelenMesaj
						response.end()
					end if
				end if

	end if
else
	response.write "3D Onayı Alınamadı"
	response.end()
end if
%>
