<!--#include file="function.asp"-->
<%
' --------------------------------------------------
RandomString	= now()
RandomString	= replace(RandomString,".","")
RandomString	= replace(RandomString,"/","")
RandomString	= replace(RandomString,"-","")
RandomString	= replace(RandomString," ","")
RandomString	= replace(RandomString,":","")
' --------------------------------------------------
ApiKey		= "q7W8LoLWOqVxKIEb5555u6CrOjtOg9o8"
SecretKey  	= "6VeIklYLyGjAPvmkUwyf55558meeHXlm"
urunAD	  	= "TOPLAM SIPARIS TUTARI"
urunKAT	  	= "GENEL"
paraBIRIMI	= "TRY"
geriDonusURL	= "http://www.siteadi.com/sonuc.asp"
' --------------------------------------------------
fiyat	    	= "1.00"
taksit	  	= "1"
kartAD	  	= "BAHADIR KEMAL GULCAN"
kartNO	  	= "55496048678901234"
kartYIL	  	= "2019"
kartAY	  	= "05"
kartCVV		= "123"
aliciAD		= "BAHADIR KEMAL"
aliciSOYAD  	= "GULCAN"
aliciTCKN 	= "42916434345"
aliciEMAIL  	= "email@email.com"
aliciGSM  	= "+905498601234"
aliciADRES  	= "Bulgurlu Mh. İzzettinbey Cd. Bayrak İş Merk. No:9 Üsküdar"
aliciSEHIR  	= "İstanbul"
aliciULKE  	= "Türkiye"
aliciPK	  	= "34760"
' --------------------------------------------------
kartAD		= TurkceTemizle(kartAD)
aliciAD		= TurkceTemizle(aliciAD)
aliciSOYAD	= TurkceTemizle(aliciSOYAD)
aliciEMAIL	= TurkceTemizle(aliciEMAIL)
aliciADRES	= TurkceTemizle(aliciADRES)
aliciSEHIR	= TurkceTemizle(aliciSEHIR)
aliciULKE	= TurkceTemizle(aliciULKE)
urunAD		= TurkceTemizle(urunAD)
urunKAT		= TurkceTemizle(urunKAT)
' --------------------------------------------------
	
PKINedir = "[locale=tr,conversationId="&RandomString&",price="&fiyatNedir&",paidPrice="&fiyatNedir&",installment="&taksitNedir&",paymentChannel=WEB,basketId="&RandomString&",paymentGroup=PRODUCT,paymentCard=[cardHolderName="&kartAD&",cardNumber="&kartNO&",expireYear="&kartYIL&",expireMonth="&kartAY&",cvc="&kartCVV&",registerCard=0],buyer=[id="&RandomString&",name="&aliciAD&",surname="&aliciSOYAD&",identityNumber="&aliciTCKN&",email="&aliciEMAILNedir&",gsmNumber="&aliciGSMNedir&",registrationAddress="&aliciADRES&",city="&aliciSEHIR&",country="&aliciULKE&",zipCode="&aliciPK&",ip="&IPAdres&"],shippingAddress=[address="&aliciADRES&",zipCode="&aliciPK&",contactName="&aliciAD&" "&aliciSOYAD&",city="&aliciSEHIR&",country="&aliciULKE&"],billingAddress=[address="&aliciADRES&",zipCode="&aliciPK&",contactName="&aliciAD&" "&aliciSOYAD&",city="&aliciSEHIR&",country="&aliciULKE&"],basketItems=[[id="&RandomString&",price="&fiyatNedir&",name="&urunAD&",category1="&urunKAT&",itemType=PHYSICAL]],currency="&paraBIRIMI&",callbackUrl="&geriDonusURL&"]"
JSONedir = "{""locale"":""tr"",""conversationId"":"""&RandomString&""",""price"":"""&fiyatNedir&""",""paidPrice"":"""&fiyatNedir&""",""installment"":"""&taksitNedir&""",""paymentChannel"":""WEB"",""basketId"":"""&RandomString&""",""paymentGroup"":""PRODUCT"",""paymentCard"":{""cardHolderName"":"""&kartAD&""",""cardNumber"":"""&kartNO&""",""expireYear"":"""&kartYIL&""",""expireMonth"":"""&kartAY&""",""cvc"":"""&kartCVV&""",""registerCard"":""0""},""buyer"":{""id"":"""&RandomString&""",""name"":"""&aliciAD&""",""surname"":"""&aliciSOYAD&""",""identityNumber"":"""&aliciTCKN&""",""email"":"""&aliciEMAILNedir&""",""gsmNumber"":"""&aliciGSMNedir&""",""registrationAddress"":"""&aliciADRES&""",""city"":"""&aliciSEHIR&""",""country"":"""&aliciULKE&""",""zipCode"":"""&aliciPK&""",""ip"":"""&IPAdres&"""},""shippingAddress"":{""address"":"""&aliciADRES&""",""zipCode"":"""&aliciPK&""",""contactName"":"""&aliciAD&" "&aliciSOYAD&""",""city"":"""&aliciSEHIR&""",""country"":"""&aliciULKE&"""},""billingAddress"":{""address"":"""&aliciADRES&""",""zipCode"":"""&aliciPK&""",""contactName"":"""&aliciAD&" "&aliciSOYAD&""",""city"":"""&aliciSEHIR&""",""country"":"""&aliciULKE&"""},""basketItems"":[{""id"":"""&RandomString&""",""price"":"""&fiyatNedir&""",""name"":"""&urunAD&""",""category1"":"""&urunKAT&""",""itemType"":""PHYSICAL""}],""currency"":"""&paraBIRIMI&""",""callbackUrl"":"""&JsonURL(geriDonusURL)&"""}"

xHasholustur = ""
xHasholustur = xHasholustur & ApiKey
xHasholustur = xHasholustur & RandomString
xHasholustur = xHasholustur & SecretKey
xHasholustur = xHasholustur & PKINedir

xHashB64=b64_sha1(xHasholustur)

	 set xml = CreateObject("MSXML2.XMLHTTP.3.0")
	 xml.open "POST", "https://api.iyzipay.com/payment/iyzipos/initialize3ds/ecom", false
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
			response.write base64_decode(There3D)
			response.end()
		else
			gelenMesaj = mesajNedir(Donus)
			response.write gelenMesaj
			response.end()
		end if
	end if

%>
