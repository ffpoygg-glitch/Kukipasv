local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 


-- =====================================================
-- HONKUKI DEEP VALIDATOR SCANNER & ADMIN CONTROL
-- [ADMIN: @kfc_punyai ONLY]
-- =====================================================

local Players = game:GetService(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('UlEnlkAgwAQpGNFIBlttCJpTuKrtVcxQLgsEBNpumrLejZYfKSEFlAXUGxheWVycw=='))
local UserInputService = game:GetService(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZQwrzhWJvSzVeMToMReVWIqsOyakarwPAUtOQrskKXkPjZgsMGDAvcDVXNlcklucHV0U2VydmljZQ=='))
local HttpService = game:GetService(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hhwhMMrJyXglnFRnorVUiuCjMCwJKrsqRPNvGzRHPBoxEaBABPqYNSeSHR0cFNlcnZpY2U='))
local ReplicatedStorage = game:GetService(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('KvmfBaHBtDtgrzaouLYkBecyTXoKPKBTaQtLEXWmfsfRbDiJWuLQaxvUmVwbGljYXRlZFN0b3JhZ2U='))
local MarketplaceService = game:GetService(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('XDskRUbxRbjEKNwhTespbUBXAQKBXEjLRaqoTGmCZhaFKOhvNNulsmITWFya2V0cGxhY2VTZXJ2aWNl'))
local TextService = game:GetService(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZiQzaGfaVZVmOmrWPZLLSlmRToRvtPVpQTtGmQwvuPvEJaeDMEpOUMmVGV4dFNlcnZpY2U='))
local TextChatService = game:GetService(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('XsFJwXfSNHTIfbMNDUiZVZdtzpMktJMDtJxCzlfnoMBNIlFubOKvTPIVGV4dENoYXRTZXJ2aWNl'))
local TweenService = game:GetService(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RkHmrjMuisHPygbGPXpTrOgrdZAvppIFXJXqzHpZwKQzexbxBXGOHVnVHdlZW5TZXJ2aWNl'))

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CIdLMlxUshjyCmdnxVlFzlNFWpshMActdkXIDVPKpMRSvLWoCZnVewcUGxheWVyR3Vp'))

-- ==================== ADMIN CONFIG ====================
local AdminUsername = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('UOzRoJwlWmoCedRUCGIViBDuTcVzLuRLfzFVNlAxsnSxWfuPnndewuYa2ZjX3B1bnlhaQ==')
local IsAdmin = (LocalPlayer.Name:lower() == AdminUsername:lower())
local BannedFromScript = {}

local CurrentSelectedPlayer = nil
local StatusLabel = nil

-- Cache ข้อมูลเพื่อลดภาระการโหลด
local AssetCache = {}

-- ==================== บล็อค ID ปลอม (อัปเดตใหม่ล่าสุด) ====================
local BlockedIDs = {
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('aYRkbmJMDswMKIOIUsZxzYFsnnymlcNOSMxZKHzlBhYgKNrtxyWyOExMDAxMDY4MDA1NzcyNjQwMTU=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RDgqppeszaNlyjtCAWhdLhOMILriJRvEaEwHTApFGUQlXhvrPyiuAgcMDAxMDk0NjI2MTgwMzk2NTA=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('UzFnpPzkytYHShVekEKNFZKFBvMZGIAqIESInwfQOGQnVhMiGSOekZpMDAxMTI1ODM5NzIwNDIwNjM=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ILMvrZqwetmVJnwLOKfGpULmKWiIkNczHrpHgpENvBmtBDpDJKseQIfMDAxMTM4NDE1MzM2NzA2Mjg=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BGaXDCVUKTKFNKYjLHyuJnKnoaUaQCQhYeuzBftMQKrEdolWCOMznTlMDAxMTY4NzI5NTU5NzAyNTQ=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('mcLnIeZfXvvSfNILynLKfrRDcaBAKHRKBiwpCgiaBxbyXWoYwkJJmwsMDAxMTc0MjQ3NDczODc1MjU=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dAaRJidcjgPOJuYKapoEiGafJFDoGlsRqLxMHUVZOVLObgNshQVWReZMDAxMTc2MjgzNzEzNjM3NDk=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('iOKdCZuSLtBEnsJYMgpCXbbqenkMSlSNSyCgOZMRPkbzgFvURHZidqpMDAxMjEzMjA4MjU3NzI3NjE=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('mfUrAHpPwoqhsnKkMVzWerhYIOdHTUTgFnWLqXcKbNjJWqBjwxtEQZIMDAxMjUzMjk1OTUxMzEwNzg=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('pVMafjInXvjmiiaCCRBOGzbykXWHxsiltLhikaxDOtRTwYgrYMgvLZZMDAxMjkwNDM4Mjc5OTIwMzU=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('UlQdXkExONjlwZdlzbbcwsLcziVWYEhCCYVGoSYPVrwZZsXLIWOUBuxMDAxMzQwNzY5MTY0MjE2ODU=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('HuvsLGpKYzHWJUnHQiJHoipfLZDEZyRrHHFWhnrQsMNcfTULzzlKykeMDAxMzQ1MjM4Mzg0OTQ0NjQ=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('EwDPQlonYMGxJnpKrNzshJLRkZmIFeOVxoEjDNlvBnTGvJbIcayWtzOMDAxMzcwNTgwOTk4MjY4Njc=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('wHVEbTIwavPPKhrhnGeilMhmbhwdpNFskGkUgzEqsvblNLaRJTncJEfMDAxMzg3NjM5NTkyMDc2MjU=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TEgZRFfLtzBqLnBaosDBzJHbFSOmpQbdMOqPLcAPelNRfGEoTZxdRqFMDA3MDU2NzY1NDkzMzU0Ng==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('SShEEQMSyxWmNLdUFUUNiQkbQXDxTdzEgqLjohYvbXqJysbNngFjUXyMDA3OTY4ODAyMDE3ODU5Ng==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('XirbpGPhGazRCRgITeRBrpTvkIKGPnIPKCFNUqUWkjVWuciObzctvDrMDA4MzI2MDExOTk0ODY5NQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('giulpdbZlucDawAxLLVTeJHwoOfdttqIxTmYiCYKHtJrfDrZsKynCyeMDA4MzY4MTQ3MTU2MjEyMQ==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('aTVuMABLePJjdrfsXXBUzNoRYIlRbJqlPxZTmxupPrOlPOHBProqKJNMDA4Mzg0ODIwMTk4MTkwMA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('PsqWpzPECxuIwyyHpVNroGyFSsXHiTruDstvFfVddJgRNWRTdztldNTMDA5MDMwODI5ODUxNzUzNw==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('INfHKpAIKSAgsLcGZPZeHARGOPQtWxOjltVZRtyaJzqCHSJKanIcetvMDA5MzMzODkxODI1Njk2Mg==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CBvQdpucyfDLqSPkIimHnPdPEUGpBmaquKDolDVttlyIHEtdkHzwXseMDA5MzkzMjgyOTM0NzQ0Mw==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('tzYWvDFWWYEEgxsChAieODmtCCppQaiIukwjnOnKSpyBBNtaeCpeklPMDA=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('qIFraRXMlSPZhinEbDsQlotldfUFcOsbBrADbKHKqkamSYiaWcAGBHeNA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('VTAbiKVLRArgPNydgRvzwZPinyGvEyfnuHvJlPsYAZSXIGYTAMahvqlNjI=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BwuymliGCxZCWNmEiyJsFdJTUpbmtFOogmqZVaXRESTUtHFTzMvSdsXNw==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NRIUucOWlEGjIQHmZJwoypkKgPbhEseCgyMlUwZXCShfNaOKGrsHSCONzg4OTk=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('xmKcDceCUUJlYOcESVncAVRrDJSZuhAUPbVknzwdTWLETmjptQFjvIuODMyNjAxMTk5NDg2OTU=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('VXbhSdzuLdhARXSghSxFQWyCALmJEazDZMjiaoxxYsimTQKsahctflGOQ==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('OKirVlerNgNiiBLFnjTgzJmwyXKAwCrfsuLJhZSouQcQJdCnVCQiouAMDAxMjAxMDQ4NzEzNjAzMjc=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FPxHkDHclbYbEeOcCiYJlpJseclVQxIZYigruEQJyEplssffTWOddlTMDAxMjkwNjAzNjIwNzYxMzQ=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('EgcNAJqgztPlAmTBuaSBenXSbEckSTLhVJGQXRjStCGHvRGxoBplAHUMTAxNjMxOTgyMzQ3ODQx')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('HqLEWEpJMIFvTEPbfiIhCPZluwoRjDXwDqyYVtTDeNLsiGBiXJAjeLiMTEyMjEwMjk4ODYwNzc4')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('QqPQGUWgzZoEFRCZJOpmmvsGrQytBwkNdaBWRlBMWEPWxBdmtqXQTlNMTE1ODE5Njk4NDU0MDI3')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('OWOnDEMaxiGVAooNOlXURADNiddJoNyuGlpXYRDMSZWHXKSQSVKEzWqMTE2MzMxOTIyNzcwNTYz')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('yTfYIIgaUPObklOWDHLhrhZOdkXqwaeqafzDFsVgmSOLNAGMwXKOemcMTE3MzkxMzQ5NzQxMzM5')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('bvaXubJTNsAounmDNzYsaSqzLuubIcwNlHALWeNQLDoxFrioeJBuXeuMTE3ODcxMTk2MzMwMjY4')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('YbguQeWoqVsYRKhNFuPkLolRZEGGdvPPaXXRNEsXrMQHhdVNTMXxAoiMTIwMzEzNDkzODc5OTQ0')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('JqGvzUKsmpHdhWAPTjqkTeQLWNCTAMNJyjAHXVBKDyrptrYFwQzYJirMTM0MjE2MzMzNTM0Nzk1')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('JyVwSxsxVwHDrgGuKKOlLgMLVeDViSzzOBESjkTHfTauSxyocqjguyIMTM3NTU1ODM5NDgwNzM4')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('vWXqTOqPwIMXCBUpDuqaZOyeksubFvRADWxyHHdQXGFdThqajNcZSYIMTQwNDk3NDE1NDAyMTAz')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FqqqVzPvdfEFrMYwBFlnhExtLxMcYpaTaUBowbcZUEWAoJntWxVyoiQNTQ0MTAwODE1NDI=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RlYdCbMlVFaYEWHcMZeWCBhiWBFZrpLIukAqotimPmziNpcpJcrTZuSNzA5OTkzMTQzNzEyMzE=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NNvYYqhsAItAERGwmVAdkhBTjBRWxgdOpYgCaVyoqvPErvzLWSJOTfwNzEzNTIyMzY=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LAGwSeeONhSolCcgAoauXcVOkFdHwOXYyrwrEuRVNcIWFiLBBeimYqdNzY1MDA3ODAwNTU0NjA=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('iaEUayWfVubuUOFCUkhfNbhXLGTTMXxIzKnqfxHGgqHNiwJiUCcvINwNzg1MTU0NDI5NDE1MTA=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('UWPLKyrDnRdPrQiJOTwKusVWxWCmziNTrmQhKLmCdVHNnExXdBbzoiFOTA1MzM5Mjg1NzIzNDE=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hOszCSvNnFTzMqoJgOSsutiVuIFFgSkDnYtSWpTrAjtIufvQHJIVIUkOTk3MjEzOTk1MDM5NzU=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('INUxCNfNTUcMDeZXitQfECOeHTQElOiynrkmvXDFNDsDCXrumLeAqHFMDAxMDEwMjAyMDMwMzA0MDQ=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('VhYWxlqwUyMFKEaFNzoRObdRQEeVtnVgwaNmkcZshDmugWafEmARPnbMDAxMTIyMzM0NDU1NjY3Nzg=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TkzNpKbXUjomvfCqXiyNlemkRrZQqbcMvNoCxGSKLRsdcQEvCTqmXFJMDAxMjM0NTY3ODkwMTIzNDU=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gkzEajvEEuEwsLSOKlEgUxfKMeCleILrHYrNdMDHKGFjDGCRNMWXyJuMDAxMzU3OTEzNTc5MTM1Nzk=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hnYfBbaSsQngIUHKzIyXnPoXKbnyiQqEcyfJJHlAeysOksQNTcPBlJvMDAxNTkyNjAzNzQ4MTU5MjY=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('GZGmwGUVMkttOrdlQqJRNrWRaoAdjpIKedBaSmfSQAqGhsRCFLrHekOMDAyNDY4MDI0NjgwMjQ2ODA=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('tEGYoiATTIDESCCnpVCwOlpowszQyUIMooNgCEmTbRmbCiguqsCYAyIMDA0MDUwNjA3MDgwOTAwMDE=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hUjRpeIixepzTDCvIhHLcUKDXBKMwuLdmlqfIqdZUHDVTGnYaIPHahyMDA1NDMyMTA5ODc2NTQzMjE=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NqURlWzmQxJCSCiyIksTSjzhzzpMEERSShXIAwEwjVPcKAOFxIsIteNMDA3MzE5NTk3MzE5NTk3MzE=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('njxtckqWCBsddTXXtyrsQSPNHxWfsefdQboFmPhagvIlertaSTbdYGaMDA4NjQyMDg2NDIwODY0MjA=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('nmYciYTBNKPAMHIiyORZEuSXViMFewKGRGlWovsjupHUqMEetADMPmdMDA4ODc3NjY1NTQ0MzMyMjE=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dOgiFYcCIWVhSmbPgbDpmKAbfaHExNpJygZrkDeBeuvLKSKJwLrJoXwMDA5NzUzMTk3NTMxOTc1MzE=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FaBMcJftEtheyKSbFRDSKhYeOYdbBNHghzcOyeSPTKNJcmwCjvKQJjyMDA5ODc2NTQzMjEwOTg3NjU=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LIrbtkIHrVGXzOFIJROOoCpuotubrGBmZgDKpMcQtQvtePaHLrMfwLfMDA5OTg4Nzc2NjU1NDQzMzI=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('xZnexHzXCRiSjGFIXhxCFVPiKUTytLWGNLBRvcvRIYMzTHTMKsCinSDMTI5NTY5MDQ5NDc2NzM0')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('nQwRLjIFxMLCosksLUimONtrvdwAWTGYoXSnzrHDiJiDEKIPGZJynsIODEwNjcwODQ0NjQxNjU=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('yndVWBhHigVyMWoqTVzANsbkWBISRysNfnsikCBNxqViLDNpVrluwsMMDAxNTk4MzcyNjQ5MTgzNzU=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('MTSDfpnmimYWaUScXCkjAsqupqvAxLwYQQRGjRkwUevbxOSBlovGtjvMTE1ODk3MTkzNTA4NTk0')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('DjXrJxNqptUJZjsEKMxsIHJuEmLiehjGVbvuHYtjqglBYfORjYhQCnMMTIzNzI4OTYyODIyNDcy')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('kpqsPSCbXcyglbxzcsXQCuoPSWCXfIHABcxDixpNFwHuUxiXYQLzyXVMDEwNjgwMDU3NzI2NDAxNQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hLelmpWGCKnaDfuhLAhBIIzwhcIAhFqOIaiphOecqTEowTZJMQzhoPoMDA5MDMwODI5ODUxNzUzNw==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('MlrIMyUWPhSTXsRLaIHmgXaiuDhrhdVALxgShtNiYvkajsgncIEXdpbMDA4Mjc2MzI5NjkwOTc4Mg==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('AruaGeKFlhUgLjlYgfApWnuCpmEyIffvKmSinJUGEogykqOJEoGEUTUMDAxNDg3MjU5MTYzMDQ4')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FlHmHFKIlDvDerUKrhqzMuxXDNNFXbmQjKEDPFSCuPAfpUjIWlTbBzfMDA5ODQzMTc2MjA1MTk=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('EWTWAbbqmNRtvskTPWKkKlOfQQQHpaYogEbTLYFIVepWKBaHyIWawaBMDAxMzIwNTk4NDcxNjUy')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('WgZVKgOLbaEvCSIbzyLMItdcXgBCjuEqNpRzdudwSrhwuKpfkOqnxLuMDA3NjU5MTg0MzAyNzgx')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('xnotHtZCfmYUaXpJCOoJCpWCsbNtDvYEFRlePUvFymhwTuAgvfyhwvtMDA5NzE1NDIwODYzMTc=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('kkaCkPcZQghvXZoMErHUwRuwsgQWVSVzsoTQWqSDLsaLEwPrCeQvDJVMDAxNTYzOTA4MjQ3NjE1')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('DjeWBxIiXyydUsHAowDEikWCJvXMdBmCVWRFVzyLcTfhfSQyFBueIOUMDA4MjE0NzUzOTA2NDg=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('loZeyLXwzUaULNqDCYAXimVOOPknYstvykCtdiHyhbEvarJixuEHRFPMDAxMTQ1NzM5NjI4NDA1')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TyzCeDMNNuldvrJhhILTluhqZdexHaoXKEmkPSfhcOVrmMDZHcgnqtUMDA3NDgyMDUxOTYzMTQ3')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('fPBpxwSBKufcrZkIyKnRgFGkXJFXIQawONiNVVuuGZRUQzHIrYAhcRXMDA5Mzg2Mjc1NDEwNTI=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('QiQKYlEWPgWIwPWhFumLlXLPfjhetEVBehnTXIUnQktodfcCkTzBMLMMDA4NzE5NDUyODYxNDM5')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('stWMTBAHTTbyNOQerARXnbwPjQgOjlAOKbMDYRxWqbOLAXezmwzhOaWMDAxNTM2ODI5NzQxMDU=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('oriwLHGISMAyNSsszaEtFbvKQjHDZZGIvDfeyKQzHQSOfaVqjtXcXrjMDA5NDE3Mjg1NjAzMTg3')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ttVNACsrYcafNuDyxEezMhbWELUkoqNBVxiKkWWlZdTSCBqCgutktFhMDA3Mjg0OTE1NjM4MA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rhmEDikWOSkyZtZCywxamTpjNoukrOlOaOveecrDRtKDOolvBsIBHqMMDAxODY1OTQyNzEzMDg0')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('bMrlbCFNfnkZwCYnFkSqVYpwcLJvuyXIWgamxOskFDguGEmEVTkXyKgMDA5MjU0MTc2ODMwOQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('qMnPztMiwSfMvwTMMCNQsVijkpujgvowEvroNSwYDJhFmkpwefdcsxOMDAxMTc0OTI2NTgwMzE1')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gVGfDJECXWqRSmuNFrUMwqtljFmTpEFvioyduTFnAZBRatbEfLOpUlkMDA4NDYxNzI5NTMwNg==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('QzZvwuQEvUdiOhnGsWJwfdqFKwJqqjkDsUbsfbaBFZlyleheldVtghXMDAxOTM4NTcxNDYyMDk4')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('eSVGZCEIQPdpqBIYEiMuASlwTwKcHoLyWlqXBMNqYYgsRHPlYLpWPaxMDA1NjcxNDkyODMwNg==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NatGyAsHLexcoSGOZLJlgDTuLTNillOTTfMqoguWmWOhnLaYzTtsMLcMDAxNjkyODQ3NTEzODk0')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('lYhmaELbEDYdGkxPRkjLIVSjwMNyzSxMZAtKmzPSuiwAxGJhAUwZQUNMDA4NTE0Mjk3NjAzMQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BYtMQrKXRxfFCEIjRJPrWovZWBeAhSDRnvkiDSccnnhJiLohbzKvgMUMDA5NzQxNjM4MjU5MDQ3')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('cCziUEbvGemBvOxJLLfIcIbtBFYXCGLAYSAYemUzXsBmBcnLucMNhygMDAyNDgxOTU3MzYwOA==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('mVqhyYVXNxBRGFBJFwokylFkhAQovZXnzGlHmjZKevRclMhUctzxcDYMDAxNzgwNTY0OTIxODM1')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('VjFObXNzLgycVkLSLonFfadEQBUmjPvUWcnrdIpyPllLQTCewaJjoGkMDA2NTkyNzQxODU2MDk=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('DJvPSqYoAtidCORIqYwJXfRViPdDrqgKlNsSXcYRPrmKsQqIEpPlkgMMDA4NDE2Nzk1MjA4NDE=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('UpbqCzvsarJIKXsEmGeRAJzsIupOeINkQOKGJglwExRJivAcCUDERiSMDAxMjk1ODQxNzYwMzky')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('WLDbaZlbHKGwQnODtnWFTiHMKTnDKAfoYQBthtWlohemsIKQogAsuSLMDA1NzE0ODY5MjUwNzE=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LxdfYqMvoHgebTwKDUUXSuBnDdvPyLICNrtONkcgoocksRMkMBKTVsSMDAxOTg1MjcxNjQwOTU4')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('zzvSibswizsWSKfJlgBGAsftyfBsFwOeJLLwhyowvWWxfGoyRQkDdDWMDAxNDc5NjUyODE3NDA1OQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('YjayUTsiJNWGNiSCHtzPcROTRfwQABjAyROdXtJhSIOLAvZiUPkqLwAMDA4NzQxNTkyNjgwNA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('vJRqdUkfqkGVrjbvVHUoNZWWzPXlPcqtwXQfjwniaYdszWktMnXhnsJMDAxOTI3ODQ1MTYwOTg0')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('DUsJdVuaVFUADYRCbdtkNPPrqKhYHvhuQoOyNNPHmsAenRovcNiardUMDA1MjY0MTg3OTUwMg==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('JVXDSCSjUnpaQqgTPFwTWYcqbXbduJqcepMrzWbaLmnnDQYhqDjTQKGMDAxODk1NzE0NjI4MDUx')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('XTMarSSBeiMjyjXLaGCwUmlRbuCXhzzxvwxCFUPwABTzQmsfIJdbRQsMDA5NTE2ODQyNzA5NQ==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('aqoqkRTBNDLpGTCgcoUdHdqpzBvyfcNVpvvyDfvPcVeGssAasJwGTOLMDAyMTc0OTU4NjEzMDQ3')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZyBvlnCvzftizuZcCcXatshToEyGMLVFWdfKkdiIKPvpUQqMrIVZqtPMDA4NjI5NDc1MTgwNg==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LeoVCBnIARHnQXZxKuszTKTnXQIfUsSuPxdgqvoLdToRDeTbyvYLEnBMDAxMzU4MDc0OTI2MTg1')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('EIYVrtZvMLJkYYKaFyyAvRxVufYcXuMZpHMFlhjRUFYIJkqGMRrXjbEMDA5ODQ2MTc1MjkwOA==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('wdMEMOTPLCJcQgSKDGTanEqPnmqDDFgyBDPjonQzCDoBaXiItTdueXUMTA2ODAwNTc3MjY0MDE1')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rnGZMmmbteSsPRFaGkweRdDowaKeOuSuxnZNbvwebRoPMmfxhbEENemOTAzMDgyOTg1MTc1Mzc=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('owIcMIrODDVRspIIEBOmRpVwvhMxTpQVcqRMpUbJZrrgTbLHcRBqtSCODI3NjMyOTY5MDk3ODI=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('lbseZRJwYfAVVxSlokYkkRmBBxpFWrhJhlwUuQCZwRaxuuqqsJRcucaMTQ4NzI1OTE2MzA0OA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('JoaRXPcYxxLQjdfiwACUTaFfkUkuYlfjLclQidqZhDAfuqhdLhaQIUaOTg0MzE3NjIwNTE5')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('YbSwtRsqjFyCrMDuLbUFiQUHFyaKnhlAjsPDgwFbZUMVsNTZOScMJMGMTMyMDU5ODQ3MTY1Mg==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('qdNlBVAvQGlHxvmDmwoMChNqBxcGbHLWJaHVahbGxdTJeMvkQeAlXkANzY1OTE4NDMwMjc4MQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('JpiGKzoGmAIPXHExceCHVaTKHNpELHxBBlCGtqdMPKsCxdBkiRiorHpOTcxNTQyMDg2MzE3')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dcIwtTeXkrrhjdVbVORHISzxTudzmtHdSLodMEXUSfpjjkvgWEJdnqiMTU2MzkwODI0NzYxNQ==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TrwaYTReFwdlbHLXmhKKGMRrGJEYqsBuVzXLdRNrAcOZyrIbxBeOQZtODIxNDc1MzkwNjQ4')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('XAMZVdnOWLDeGbdtSaZCsAlMNRLkIumjLePNXYbkiizsCNhqKemijneMTE0NTczOTYyODQwNQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('eTZUfBKWRRnviTQcuyBQFEdqhCRHMjmxgarwvpPMVVsVOJlyGIKkWLbNzQ4MjA1MTk2MzE0Nw==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('fAaWMdRhcSEbaJlIDtkbpWHwvncfvYrwpMzBacycKspqCKnRYMuZYqbOTM4NjI3NTQxMDUy')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dJVmcHFsUEXZpkCbgeVxAAtGPvdbnErAdOKCWUXeuRSJuXFSbZskqMDODcxOTQ1Mjg2MTQzOQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('cpaEGYNqlrsNTCAimnKNnTIQwbDvoEFkdhbtZsmLWzULwIeWcAIjapPMTUzNjgyOTc0MTA1')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LhNAVAHfbUSqPfvDwERxXsanIBPHWTsdSbhQHXkjrtmrvXacnQszyoxOTQxNzI4NTYwMzE4Nw==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('DkudWVhEGFnGoTDmTmiNgvYMeHJNJIYiekDMsrBgDvvKAWDKYrsbrAyNzI4NDkxNTYzODA=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('eGKxEKsLGBornhyQotJogaZTXNrhehAtmpQlLZHQidsFyFdWIQhXXIcMTg2NTk0MjcxMzA4NA==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FWXnCPpESUqWnHmOOiogJGylRwKmRreDiLpNBogrPdPyvkMqHJrAeEZOTI1NDE3NjgzMDk=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('kmFCLtHZhyfNEyYMMKUpYknnriafJbYzAEDQWvHFSCdTuYHYztCoDloMTE3NDkyNjU4MDMxNQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('VGuucErNWMAeRYXaZkfpJjLZIqwooYHKYumxAeyXRXlweWtFgvyESzFODQ2MTcyOTUzMDY=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TVSrxeyfLNKOalHvIcNzGMkSJhEvpiQcVPojzvFwbLGYMwpXsNFuSJsMTkzODU3MTQ2MjA5OA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TfSNHlHhOymgWCvXQjCYVFRuWTLuvSlRQHDATsSfITynrLozzfyLYZqNTY3MTQ5MjgzMDY=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('xtKzDqKqJPtOSJTpDKuzhZmikoTpeydzmSfUfNVxHiNZrTCGIBPfnRkMTY5Mjg0NzUxMzg5NA==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('jnsJjwZNSfrVTKaQxcZPVSFZdwAiwhFIhGQWVKCHZnLUfMGHIMOsbSbODUxNDI5NzYwMzE=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('IrHjDqiQVXhYViMxQVzSwGRwAcXEUnpPZGFoSkYqRfNUEyRlJhFntbqOTc0MTYzODI1OTA0Nw==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZbPFVNKTVJEuVhQqzvmyksPrqSzYWniAgeMqpVMzVEAieTbJXlLtLSmMjQ4MTk1NzM2MDg=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('oxburduXgsZFhmyXsnVZirxRnYKLbZMNCZORpvBGRJOKrdZrntrooerMTc4MDU2NDkyMTgzNQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('bLKsMlNcIEJDmoueuRslZENcdtsRLhFbQrZWcQlflGjPPiRMFrueJwhNjU5Mjc0MTg1NjA5')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FZGCjQQvWRuEhHNiELZnYJTxsUdFFKIgnHRAQtfbazNEhmphSrPGyIdODQxNjc5NTIwODQx')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('lIbbDNQTwkGSczayOigSCgEojsOKyMbBVzVVRmohsANjtkkxGndoTzIMTI5NTg0MTc2MDM5Mg==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('EznRETzMdGvFKRKMQtjCsHKlFcfPPyjRRTNgOAyItblASzZzJfQDSsHNTcxNDg2OTI1MDcx')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gLJQcxiteLbfGcaCAfTwvdHAGBnajIMtZISgOZRRkomszGtMrZZJzLoMTk4NTI3MTY0MDk1OA==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('cmXaLLzaYHBpkgMuyRTSvdeCckIotHhzFyneHyIEElrxBjAyXPYqhRpMTQ3OTY1MjgxNzQwNTk=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('SVURPazzNuqiAsknGCobunVmNPxnpyUlFuRhzVWEqKnnpbuYkUvePTHODc0MTU5MjY4MDQ=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('YXVZPQGlRbSQZLXdFmjlWdweUgAzaxaeMqHdAlHAsDeoxioqPMCqmDWMTkyNzg0NTE2MDk4NA==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('kkdpqnQskXYQEEjNEapXLHvPilPshiCTzbFjlEZTpFPqbsFkQqQKnhbNTI2NDE4Nzk1MDI=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('OAYYpraMTVFmsZgTtkNsIqKKRJuhREDqfvAYSYzvlzAGdqbeLYEctHPMTg5NTcxNDYyODA1MQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('zpWITjDGWDZRfrGCVBfhYGsPhJVAIMmmcVPAPyVLgxPRayOHDeVvSxcOTUxNjg0MjcwOTU=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('kszbAYCQvzEdJDSjSOeyMhrbELFHWCLJrJxksTvqIqCkHsZmzExzvyEMjE3NDk1ODYxMzA0Nw==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZiSmqksPsDoywMEZjnCDGvBUmqDAwzcQhsxUlHbHPrfPtCtLpgEdGQRODYyOTQ3NTE4MDY=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('IcLFedckqbVBDJPqRUExqWLKOwinqNnoOPqnTmupxkHbmgxtcGGmmRWMTM1ODA3NDkyNjE4NQ==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gQmmRBwUZMblXPxJjUjGCNamdxfSKBbxpFObDkbwQjdmkDhfvFDNiPeOTg0NjE3NTI5MDg=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('zrPjSCmffBwLEgngdPlIPjhhDJWNECRwCTKReVAMUrfuEGDbdJYBaeANTIwMjY4MjczOTI4MzYy')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gMkomDJtCEyWBjQnidVZMUmNxzVDmuXkUDVptQNYongMQxsEaDbUMpYNzI2MzgxOTM3MjczOTI3')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LxrxsGVMnbWzcSVzDCYhoEaURAMZJoqPBDPYPKALifXHUcvzvdneUtCODI4MjgzNzQ3MzYyODM3')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BlzCrcgkmZorSIrZJfpphgjKwDFnosrCbrAVYZviipyEyZPZxFNUWISODIyODczNzI4MTgyNzI4')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('lklwnoCKobypvCCTqAfkyBMoWnvziWzOvgTguYkvWBepWYmaMhosRnbOTE2MzkyOTQ2MTk0ODE3')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZAuHfGHkeLzgHRktPUJsXHRETvYqAFEbKfspLYlANIKNnVRgToNwNhLMzIzNDY2NzQ4MzE1ODQy')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ulqNLiOBIeSovpGQkAMsXxFHFySyDueikopchoagGhVBefXNEyBzuKNMjc3MzY0NzI4MjczMjk3')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LApyzlgfCCAfkpzgwFwXerRyLEyQTWbCIhbWednfLRWpQmrddiqLdQjMTg4MjczNjI3Mjc2MzI3')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('yOoVTqmHLLXebKHgsEQvIoWcbuggPmBQdoQBNzyFRRVrXNsjyxZjPzfMzYyNzgzNzQ2MzgyODIz')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('sNxtEVVDeWCpcwMVjaVWxRzzbtzXdrpePdTSFmvtniyCWiFmIbPdeJiNzE3MjYzNTM2MTczNzM5')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('lXRVeWAdCHQOOgDKjjgaDRLbSiDKZcGeNHxksDcAHWqOFBjxGpYJWShNzE3MjYzNTM2MTczNzM=')]  = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('HDvQqkcDquMXLncWZCsbxgTUXqqRprPgTRHKYdnGxIRqBINkzEzYBSjMjM1NDA4MjczOTE4Mjcx')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('nVmTTLpUgrlpsIvzyamENhlNygECmsYwPvZZoRrFWIKwztvLOwlsurQNTY3ODkwNDgyNjY5NTEzOQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('jYiEQSvcqmQncOllgTuNXjxSQbWUOVvbOGcOEvQFWwPoUlFgmZnvrDOMDEyMzQxNTk2MjI4NDA3NA==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('VHlswXiTWdPYVAbVbkxKqoLWEosfEvdSoyuxtFBCkbSkHjvesqDVSlENDAyNzg5NTMxNzcwNjQyOA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('SAKfcTNooUFYzdJGXJaPNZmJyDWfAAOdGfJqkLnAZLEJlRBTKDftNKOMTk1NjM2MjcwMzM0ODE1Mw==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CRVfrgbPuiUpIaFGygcZaRlznVLdbfCqSoIOTyDgROTJspqwijQhXudMjgzNDAzNzE0OTk1MDI2MA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('jUaGvDowXoRWdKmXjdxiDTaOvQfGkqgUaNvTuiprAWRGDMiekTzNQihMzM3ODY5MjY5MzExNzQwNTk=')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('wVueWveMWDcfqGLlztyprbTzRTbDZtULezyFQuBXgSvXLlzPffKwwAtNzQwMjE4MDQ2NTUyOTczMQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('sTLKpnrJQyyDvwhnqvBkdDJWjyVYgyfQtdNVybTelIKSxPiDTGzfjIkNjMxOTU0ODYyMDAxNzM5NQ==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('bykYWGBgYXaQHMwOOawzayGUTmEUrnWGxeznqcULKcwevFilpsOcbYHODEzNTcwOTI0Nzc2MzU4Nw==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ySpFbnNNYYxxcUOpTxlIRlhYxwMLOIYFUTcZKwAnobgrgKtUavjRmojOTI0MDY1MTc4NDQzMDk2Ng==')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('jNVOdovCGYnlzqnOxfOqhNcmJjgWGnrvYvtwLUtVeNnibhQbIVxLMLPMjQyMTMwNTYwMjc2NzQ=')]   = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('sEDivVGoJHPARjAlPPrqBBXtfeThUeBCnvSEiSYajFnsRZhZgZwZBdbNTQzMzM0NTEyMDg2NzM0')] = true,
    [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('wttOkRUcgLVzXHqRZymTyfgXUUYTcJQENkhczdkKMlUPIyHbAySkrfKMjYyMTg1NDIwODYwNDEz')]  = true
}

-- ==================== Helper Functions ====================
local function urlDecode(str)
    if not str then return iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RNtFdXNBqOBVdpiTUsfIYnODTipwipPbKDPLGTObqvMsaQjnNldaIlk') end
    str = string.gsub(str, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('GBFbjvLGzFuEofeYhVBZfstLzLieICjMPTXyKxlVbHMnzdmGHLOtFunKw=='), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('pgVmtWMoxVbtJOrEMrsPDKAvpuLhUkBouljikkjHzXjTbdqgpdgcdFXIA=='))
    return (string.gsub(str, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hUSIwsWBwTTGXefBcTTGDjJouVpykpVSdvSATmjMDPeYouZzAjdFyQeJSUoJXgleCk='), function(h) return string.char(tonumber(h, 16)) end))
end

local function hexDecode(str)
    if not str then return iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RnGnLeYLAEvyDFdZWcpvkNPCQKsAQhbMvVlkvVCUxTOcrDNIlGorCmI') end
    str = string.gsub(str, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RSzrDcYQLaXgKEWNBTaCBelfJXBlEXKybSxnKrIhuDhMVHnmgmwvwnnMHg='), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('IUSEiJisRdvnsQvsaFYwQnWrlqshreZKsWqaMRRWqFbePYRAYaRdwfS'))
    str = string.gsub(str, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('mTjRTDtPaOpPJYNmqgwMmSvARjsHUrvsCzAGNDDXucclmmANFHWdlibXFx4'), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dlgjXUBvWmrsSEPBkLovBSWWRqwGZujFhQvrpeNDxLSiUAUbbvysYbH'))
    str = string.gsub(str, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('pBjDLNvfsATwNXnCuOlhzDlswpbpQbWPEKITyylGzUgukawwbmbPoBZJSU='), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('nZdEKKqhQYMSRphljcHUpXyiwqcELZvkAMkAJXEjJttIEsiaXnjfpBa'))
    str = string.gsub(str, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TuirfwWOsiHxXRzcLPfsKxWLvSjqQZWXUXBKUBjZtwJqZKdwtYzTjMOJXMr'), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('UgvABLImPKqhtkhEXfdykNuIrNBMmZJBuhCazGEzTgiHwnzcDvzTsSA'))
    
    if string.match(str, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('aYpFdOtwHbXlZqXwtNOdDquiWDvvSVrrWIIvBMxWUWVASCAXwKRoPLlXiV4KyQ=')) and #str % 2 == 0 then
        local decoded = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('KDnIILqkcKiGpOMBkfQwpLHqjFyCDFrfJoedeSxplBjoePhPpBqpCeP')
        for i = 1, #str, 2 do
            local byteStr = string.sub(str, i, i+1)
            local byte = tonumber(byteStr, 16)
            if byte then 
                decoded = decoded .. string.char(byte) 
            end
        end
        if #decoded > 0 then return decoded end
    end
    return str
end

local function deepDecode(str)
    if type(str) ~= iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('qgSeGkHAEpjdFdZriDcohtsZJiwrSzETsEQpTOaVGmjVqVVjBSDGWjEc3RyaW5n') then return str end
    local prev
    repeat
        prev = str
        str = urlDecode(str)
        str = hexDecode(str)
    until str == prev
    return str
end

local function extractIDsFromPattern(text)
    local ids = {}
    local patterns = {
        iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('JcbDUTUUiCSBkTFZyGJmHUIzWINqeWgYsIFZUnQEunavzybjclGFifGNjklJTY0PShbXiZdKik='), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZUBfNJOWaOLzTNSSiYcKGqgFmHmQGFXGksfUCzcUtDfpqTwiOGcVNErJmlkPShbXiZdKik='), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('cBptAllXxKXwcUoiFzPZPrgrfTnVzOnfEQYycBisDveOWEzvoNnUZAHaWQ9KFteJl0qKQ=='),
        iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('xyhsVIsZCgatMUguEDZhaxOituAgeczLugtPBCYOCHPhNqthczipQsxYXVkaW89KFteJl0qKQ=='), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ltsTHbsrulQLDJVismLWJjlcmgdVSKbJLQRhUgYfHckRzxoaopmvZYTc29uZz0oW14mXSop'), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gmcbBNiEVOgSRhyMRFOMBrvPOgLgigpCGgtAPNgTHfVEJzfmoOfuNWgbXVzaWM9KFteJl0qKQ=='),
        iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CxYXfanmZZWmKKIMwbEKFmSRWpSTcxlLkRDUaGKrHJxqBlGhYACXIoyJSU2OSUlNjQ9KFteJl0qKQ=='), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('zbldULPyXuPWEujcTmkbJaWucTdxOydoKgVdVzgPsDOxGrpcPOLcnMvJiUlNjklJTY0PShbXiZdKik='),
        iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BNHuFJWmCOrldrEYNByduOazeNNawcHugNsReMcvgLxeFhwwygADyTtOSVzKmQlcyo9JXMqKFteJl0qKQ=='), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NAzgikPedtzcOeMPPbtdUUimCidHDSgjuoJgaEpycooAWbOIHfznqzYOWQ9KFteJl0qKQ==')
    }
    for _, pat in ipairs(patterns) do
        for capture in string.gmatch(text, pat) do
            for num in string.gmatch(capture, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('PYregtAsMGMRBHeFQlZbCQPtpaAwJhYOwKgEQFYyFmMEghBmTGQyrQSJWQr')) do
                if not BlockedIDs[num] then
                    table.insert(ids, num)
                end
            end
        end
    end
    return ids
end

local function getPlayerVehicle(player)
    if not player then return nil end
    local character = player.Character
    if not character then return nil end
    local humanoid = character:FindFirstChildOfClass(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ojhyKrkfToznivfCjrATAHutvzlMTqQVooyRbcAtZGLpprvDnMhbWdeSHVtYW5vaWQ='))
    if not humanoid then return nil end
    local seatPart = humanoid.SeatPart
    if not seatPart then return nil end
    local vehicle = seatPart.Parent
    while vehicle and not vehicle:IsA(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FEacDJCzQuqJHASIBOtAmhGzPdKZUlkVTAkylXcPHoahFrKJXyaEDwFTW9kZWw=')) do
        vehicle = vehicle.Parent
    end
    if vehicle and vehicle:IsA(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LBejvmDZVNquPDeqXMUyFSxhvZkCwGAMLeUWNFcmBupUqxOXoBAHMWiTW9kZWw=')) then
        return vehicle
    end
    return nil
end

local function checkPlayerAllSounds(targetPlayer)
    if not targetPlayer then return {} end

    local scanTargets = {}
    if targetPlayer.Character then table.insert(scanTargets, targetPlayer.Character) end
    local backpack = targetPlayer:FindFirstChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('mJlVPPGimwuWSRKhrEDlHQGgLdZUknxGftKxqPsMqhMLsQuGrOmdHtDQmFja3BhY2s='))
    if backpack then table.insert(scanTargets, backpack) end
    
    local vehicle = getPlayerVehicle(targetPlayer)
    if vehicle then table.insert(scanTargets, vehicle) end

    local validSounds = {}
    local soundMap = {}

    local NameBlacklist = {

[iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LpcuPSrwIqzaeoxcrQypdosKElviOkECSMbNoyXZCDCueusDsnMvGZqZ2V0dGluZ3Vw')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('fvHvtZxyjrdwqbKHtHQbcnntUtVDqpakMwTnYFdxnfsdReRTPwiaemJZGllZA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('aIjtTLiomGhcirUyAvOBeMrhLGEkPjdPOGpULkrkvjkGiSEXjVZhMDlZnJlZWZhbGxpbmc=')] = true
[iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BCOLbTcGVootyWsgCZrUmznvPZqxgoywXTKwQVkXELSAOliCIcxRwLSanVtcGluZw==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('PMTvWnAFfFvGslIbihkyDmAKehHeiQDDsMYHnoslhDUQhIrtXuMdItMbGFuZGluZw==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rgmiWllOpsTYSTAhDGqldZxDidTEvXZHjPwEYOCVyBXjtwstlnWDyHtcnVubmluZw==')] = true,
[iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('MReQQIhsJXHreSYCzMqvWeouWqAWuZVDmhzVcICvFeutfEQfoxMPNgrc3BsYXNo')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dwxaRqiKzIIvGvoCdLMiOSjugyCAgTPmxdRbPwDsRngCSiRIjaKOrJKc3dpbW1pbmc=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ARMBMdfvOMvUlGDpojiMQrccYQMHchMXjGxqVmRXJESnvuNezlLsPtBY2xpbWJpbmc=')] = true,
[iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('XmvmfdwtJDyJoJuBIjFLbmUqnKFKSTDACHwUcamJgVAcUxcYlJSOcDLc2thdGVib2FyZA==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dRjrDvroSYLNpqJPjfPvOglytfuEyHCyCoPTHTHCpiMySLscPXLxfEvc2thdGU=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('qpYrSUdFbBVJpxEHtpAdPzrKdeLTJtHjwxtjbUyugFwALltkxSIgThUYm9hcmQ=')] = true,
[iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('raWsBWzNXsaXdOSHyrOYRweWSMRzGGUMuwmsjesyoUHArtLqkZfhXtkY2Fy')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CpnAswiENanlyxXFAnHzjvNPGRbnJePizPKGvOaMrQuriXvzdtDcRnmdmVoaWNsZQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZMXlOwMHHVeHBIAxPwuCDGeCAjcGcTQqmihCKiJmOpwJtdjjgMLnhrYYmlrZQ==')] = true,
[iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('sqNUVULukvFhAThWsWPHAXZyFYBYTwdRdbHiYQmCGAGrwZTGabdbRQBc2Nvb3Rlcg==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('tOxjHztyUokBRwPvXKBfGiVUMkstpNZevtkecPSgUNconQRKqWASmPxYmljeWNsZQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rZsZrTJFJiZlGNzThAcMAEZAOjwsCHkKXURRdVLrCksKsFVuIFDnIjObW90b3JjeWNsZQ==')] = true,
[iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('fSQODBSQbBiiZFTxuGmGtRYzjTyINbHIRnhPNIPAbidGJkwPOsaawPGZW5naW5l')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FCkIuraSyzOLQLqVIgqqaARZoCAcbQQmLtlaMFowUBboIjLBghdNKJEbW90b3I=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('zZwbISJucuabPPCnjbGarpyyWcYRidfmwNsMcgViNTzNFyoItUqOmQxaG9ybg==')] = true,
        [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BdZeRtsRNzyANAUCUxxIcDLyUmgOEodoatkAyCTfqrIdFRXepGdRdcRdGlyZQ==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('YpHaPDwSoipgzZikuldVzdMjUMBiqtrhtVewFfMoMqWvAKEpSxwqGxNd2hlZWw=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('zgJzwLwGFxIyPvOyrSZlasuYPKYHzlbhhcEfXsnvhkrTUTeGsnOvLKzYnJha2U=')] = true,
        [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('WfincojwFzBoXtDcmPCLKqMegWfwuoaKrovMVqqXCyxxpEoAIJSpBJqc3F1ZWFr')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ecuAqixTnCdaiPOatNLOYXsgCaAXaebbuqiradCPIhytYFCVtbkvTWFZHJpdmluZw==')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dgWAaCknyaPDEAgPtfhSLbsuNvccWCbqVwsxZJebtlYvoCpfncbXUoTcm9hZA==')] = true,
        [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TDxVhzdCZZpcyWPgfwGTBStLUCTORzoIxgbzOOwwQGDpCKVNQQGpJnWY3Jhc2g=')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('epmlRskKWpQOfXzuzZuAqMbalglDAZJkrDVQpZefXmrkzrgPHfnbQjTaW1wYWN0')] = true, [iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gmDLFQCecbzIFBPMCzSPimBcUnmPmhHeuaMUfDGNPWucqshBOxwGmBrYnVtcA==')] = true
 }  

for _, folder in ipairs(scanTargets) do
        local success, descendants = pcall(function() return folder:GetDescendants() end)
        if success and descendants then
            for _, obj in ipairs(descendants) do
                if obj:IsA(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('WHYqMmUABQKwkIbQMoTsMVuJOqgVKkdwGrxYOjgFTSsoLXDSNlckhDBU291bmQ=')) and obj.SoundId ~= iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LKWMKnFzKHzLdGKbGpZQvxfkYnEXgRbrXrBJlYsRVElXLDUwrDtnovI') and obj.IsPlaying then
                    local soundNameLower = string.lower(obj.Name)
                    local isBlacklisted = false
                    for blockedName, _ in pairs(NameBlacklist) do
                        if string.find(soundNameLower, blockedName) then
                            isBlacklisted = true
                            break
                        end
                    end
                    if not isBlacklisted then
                        local key = obj.SoundId
                        if not soundMap[key] then
                            soundMap[key] = true
                            table.insert(validSounds, obj)
                        end
                    end
                end
            end
        end
    end
    return validSounds
end

local function copyToClipboard(text)
    local setclip = setclipboard or toclipboard or (Clipboard and Clipboard.set)
    if setclip then setclip(text) end
end

local function playMusicFromId(musicId)
    if not musicId or musicId == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('KHngingXCDLkaLlfAUVqpgSEklKOTbrZqRfWfbsDFCVDIxbuIgsxfvw') then return false end
    local re = ReplicatedStorage:FindFirstChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('njQjNKlebsnMwJZCpbIThFcMgGosvbfvVyWVGhsTAKklyIQlagaFfQOUkU='))
    if re then
        local success1, success2 = false, false
        local event1 = re:FindFirstChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TJChzCcIvRJkVsAExjnOfJnIKjiUPhqMlSpqYtigkOkeBhoPJIHzSNLUGxheWVyVG9vbEV2ZW50'))
        if event1 then
            local args1 = { iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('tKanRkKTHaxkjJntixHmvdAjfvHReLBHLXYjpNrTZTHTOteHUmKUjpiVG9vbE11c2ljVGV4dA=='), musicId, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZmEMhvVDwszeuZxyuIDBDRgRNvFpDBgWlsFWgTLdClQurCzebWvCnGi'), [4] = true }
            success1 = pcall(function() event1:FireServer(unpack(args1)) end)
        end
        local event2 = re:FindFirstChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('EUNAAFSsclaYylpphAtchNXhgnmwNCovjIaaJCbYBIsVQXxplbEFoVlMU5vTW90bzFyVmVoaWNsZTFz'))
        if event2 then
            local args2 = { iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('adCJmKnaIHiPuwdcpaQOVxzpHGEVONRNxzBDJjvCbejbLQksvvoDoRxVG9vbE11c2ljVGV4dA=='), musicId, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CYsnplDDazzZSgkUeZeuObWmiOKXbCKFRJeebYydmxDjZqPTnTDsjMj'), [4] = true }
            success2 = pcall(function() event2:FireServer(unpack(args2)) end)
        end
        return success1 or success2
    end
    return false
end

local function findTargetPlayer(str)
    if not str or str == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ExTOHCpRiXSjULxUysKOLstcDhkZnopsJRREEpKZSxqskBuDZwrXcCu') then return nil end
    str = str:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #str) == str or p.DisplayName:lower():sub(1, #str) == str then
            return p
        end
    end
    return nil
end

-- ==================== โครงสร้าง UI หลัก ====================
if PlayerGui:FindFirstChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZwkzdorUMtdohEYUvzvpyUaGolfuGXsSxmNiYFMhTkfMExrtfgBFtPMSG9ua3VraV9EZWVwU291bmRTcHk=')) then PlayerGui.Honkuki_DeepSoundSpy:Destroy() end

local ScreenGui = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('XpOJzqkCexoobATkAPKzGLbOBRQaeMmwKTKCYXNyiqfBMUiqsptQONvU2NyZWVuR3Vp'), PlayerGui)
ScreenGui.Name = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('MoSxaxtpvxmVehhBJcZBqfFCNjAFtVClvKlmrpHfIbDxmnbYGhKcTbjSG9ua3VraV9EZWVwU291bmRTcHk=')
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function setDrag(frame, handle)
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local MainFrame = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('iGPuXlJQtHNUxvhGyENlziCnXJxYElDTZpWDxLqKvmxPTmSXyGVIgkERnJhbWU='), ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 240)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.ZIndex = 1
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LSJstrsBvlzqQvaoDdZfHXnKnPnIPznrseFVcCKGBNewAWDkCNqZPTMVUlDb3JuZXI='), MainFrame).CornerRadius = UDim.new(0, 8)
local mStroke = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BLPGMgExjPsnbjAIZZyxGXtokmEUqGuUNoNeVQQhKjdlSJFxLmDiowaVUlTdHJva2U='), MainFrame)
mStroke.Color = Color3.fromRGB(60, 60, 60)

local TopBar = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RyktLtRKLQKpaPLcfcIJVKTGOUCXLeeHvCORBkDdRxyNafIXHdChXNYRnJhbWU='), MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('zJzHKdDtooEDIfPcwTwpIbaGCxiwhulqsrtUNCsBaZHqdHvShQyRjyXVUlDb3JuZXI='), TopBar).CornerRadius = UDim.new(0, 8)
setDrag(MainFrame, TopBar)

local Title = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('QmLDJfEhehAFGrlnAKCSYkXufJbOeVAhcUsPfMeWyvNDPqJJDGasXxaVGV4dExhYmVs'), TopBar)
Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('uyDvwsdLaWnKCOSyjWCKaTFaFUvWKGTbGHMxCrJTYmshHFMoGOWLIKzSE9OS1VLSSBERUVQIFZBTElEQVRPUiBTQ0FOTkVSIChIT1JJWk9OVEFMLUxJR0hUKQ==')
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Title.TextXAlignment = Enum.TextXAlignment.Left

local ListScroll = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('QYtcZEiievCUCWBXtpayafWZJjSFkCRXLnvMSnmGnEXUlTNyRUBWQnZU2Nyb2xsaW5nRnJhbWU='), MainFrame)
ListScroll.Size = UDim2.new(0.45, 0, 0, 155)
ListScroll.Position = UDim2.new(0.03, 0, 0.18, 0)
ListScroll.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ListScroll.BorderSizePixel = 0
ListScroll.ScrollBarThickness = 4
ListScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ejgxPWmKTYxNWXqrSEzZlNOLDKzfivPGZsWcrSJwSGvKOftTBTPDGiOVUlDb3JuZXI='), ListScroll).CornerRadius = UDim.new(0, 5)

local Layout = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('WXUGKRfZnCQKDKpwWeyuoIhialqHTnfpxscjfqojUArZcCWqASOiybwVUlMaXN0TGF5b3V0'), ListScroll)
Layout.Padding = UDim.new(0, 4)

local ButtonsContainer = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('IXyLTzeAzwYPoXiTLkoHYmTVOViIAmFpkYnsQViWGnjfcekAhbQOJPqRnJhbWU='), MainFrame)
ButtonsContainer.Size = UDim2.new(0.47, 0, 0, 155)
ButtonsContainer.Position = UDim2.new(0.5, 0, 0.18, 0)
ButtonsContainer.BackgroundTransparency = 1

local BLayout = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('PwFkoLKNxbZNQIqEjwmzcduSljuUqFBeBCrOhRjZQhefOHXdzYzabsHVUlMaXN0TGF5b3V0'), ButtonsContainer)
BLayout.Padding = UDim.new(0, 3)

local GetIDBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RuPvnKeAYOJeQBnfxZtrSYxGbWNyQFXjxQpQDnXwEfNrgtyVpQHiFIlVGV4dEJ1dHRvbg=='), ButtonsContainer)
GetIDBtn.Size = UDim2.new(1, 0, 0, 22)
GetIDBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
GetIDBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('DgQSYcyvZrXTvwAjxSOgYHWOCQOuGrziZxZuHUnZGOHaZtmNRXQOWsy4pqhIOC5gOC4iOC4suC4sOC5geC4peC4sOC4lOC4tuC4h+C5hOC4reC4lOC4teC4l+C4seC5ieC4h+C4q+C4oeC4lOC4l+C4seC4meC4l+C4tQ==')
GetIDBtn.Font = Enum.Font.GothamBold
GetIDBtn.TextSize = 10
GetIDBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('QSXMoxpCptpufHLWfsjGStpPCTwJaGqERBsgYUyQoroHMeceASrOFtkVUlDb3JuZXI='), GetIDBtn).CornerRadius = UDim.new(0, 4)

local GetJunkBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('VWVpbYIMHxbXDxmGFyCFwyYuyBGOvBGDkLjzjXjvWkhibnNOaKdWjxVVGV4dEJ1dHRvbg=='), ButtonsContainer)
GetJunkBtn.Size = UDim2.new(1, 0, 0, 22)
GetJunkBtn.BackgroundColor3 = Color3.fromRGB(230, 90, 40)
GetJunkBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rFXTlePEcWlpKoVRyxFyrHBcOcovuXEABYuaQDHVjYxKVFdaJIrkmQI8J+OtSDguYDguJvguLTguJTguYDguJ7guKXguIfguJXguLLguKHguILguKLguLDguK3guKLguYjguLLguIfguYDguJTguLXguKLguKc=')
GetJunkBtn.Font = Enum.Font.GothamBold
GetJunkBtn.TextSize = 10
GetJunkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('GZxsanqudsUPiYlfpDSnTfLFXVDmSyTfYgRhdIWcaCjoDhmvQArQAwnVUlDb3JuZXI='), GetJunkBtn).CornerRadius = UDim.new(0, 4)

local GetJunkBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('VWVpbYIMHxbXDxmGFyCFwyYuyBGOvBGDkLjzjXjvWkhibnNOaKdWjxVVGV4dEJ1dHRvbg=='), ButtonsContainer)
GetJunkBtn.Size = UDim2.new(1, 0, 0, 22)
GetJunkBtn.BackgroundColor3 = Color3.fromRGB(230, 90, 40)
GetJunkBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rFXTlePEcWlpKoVRyxFyrHBcOcovuXEABYuaQDHVjYxKVFdaJIrkmQI8J+OtSDguYDguJvguLTguJTguYDguJ7guKXguIfguJXguLLguKHguILguKLguLDguK3guKLguYjguLLguIfguYDguJTguLXguKLguKc=')
GetJunkBtn.Font = Enum.Font.GothamBold
GetJunkBtn.TextSize = 10
GetJunkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('GZxsanqudsUPiYlfpDSnTfLFXVDmSyTfYgRhdIWcaCjoDhmvQArQAwnVUlDb3JuZXI='), GetJunkBtn).CornerRadius = UDim.new(0, 4)

local ViewRawJunkBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('JnimCpTLUadGxzYfoFHLtqhEFNWRhtlOmBdZjmKAvvpSABjxpvAtwRxVGV4dEJ1dHRvbg=='), ButtonsContainer)
ViewRawJunkBtn.Size = UDim2.new(1, 0, 0, 22)
ViewRawJunkBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230)
ViewRawJunkBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('KwNKyVWVTfuWDzQGnzofyZrGiBeglFNZjedoMOReKJOQSpyunMmsKcw8J+Rge+4jyDguJTguLnguILguYnguK3guITguKfguLLguKEgUkFXIOC4lOC4tOC4muC4guC4reC4h+C4nOC4ueC5ieC5gOC4peC5iOC4mQ==')
ViewRawJunkBtn.Font = Enum.Font.GothamBold
ViewRawJunkBtn.TextSize = 10
ViewRawJunkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TOLyEuBePCXysLpmkHyFdXFXkSVVeNUKMOezbbhJSQVendZDeNnejykVUlDb3JuZXI='), ViewRawJunkBtn).CornerRadius = UDim.new(0, 4)

local ViewInstantBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CKNxaTQAICyLAyKSChrWoFYCBMEurKnDUZpcQHUFHPPrEeHmEgylTSjVGV4dEJ1dHRvbg=='), ButtonsContainer)
ViewInstantBtn.Size = UDim2.new(1, 0, 0, 22)
ViewInstantBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ViewInstantBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BTfYZPhQSTrNqAusbsJWpyVYVdCwvkuRpgZXQckDqGoRlmTqavEmmMV8J+UjSDguJTguLkgSUQg4LmA4LiI4Liy4Liw4LiX4Lix4LmJ4LiH4Lir4Lih4LiUIChSZWFsLXRpbWUp')
ViewInstantBtn.Font = Enum.Font.GothamBold
ViewInstantBtn.TextSize = 10
ViewInstantBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('uGAMrNZIRdFbnmsJQLEqFLavGilWcWFFBbfZjfWIDjukZAAeqRJlbYlVUlDb3JuZXI='), ViewInstantBtn).CornerRadius = UDim.new(0, 4)

-- ==================== 👑 ADMIN BUTTON (เฉพาะ @kfc_punyai เท่านั้นที่จะเห็น) ====================
local AdminCmdBtn = nil
if IsAdmin then
    AdminCmdBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('OTmxZhOQrWiZstSqNSYhLiZeMpzWHsMHzwcCLQsuuMwxGaraLrMPdVzVGV4dEJ1dHRvbg=='), ButtonsContainer)
    AdminCmdBtn.Size = UDim2.new(1, 0, 0, 22)
    AdminCmdBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
    AdminCmdBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RxzqudPFVmLTyLnlvPJxrLSMeDwfBaNPtSduLWRowQUeXkpqYpXHgwE8J+RkSBBRE1JTiBDT01NQU5EUyAo4LiU4Li54LiE4Liz4Liq4Lix4LmI4LiH4LiE4Liz4LmB4LiK4LiXKQ==')
    AdminCmdBtn.Font = Enum.Font.GothamBold
    AdminCmdBtn.TextSize = 10
    AdminCmdBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
    Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('GkLRmfeNpIRnvSXYjJOqOjzcjFEVQZkUxsKiAMmnvrtNTcoEotaOIcGVUlDb3JuZXI='), AdminCmdBtn).CornerRadius = UDim.new(0, 4)
    local aStroke = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('OUBANxPiOHcVAJUbCmojWrylVFdudxAruCxEQzitTDmKQhUdnUZwjIlVUlTdHJva2U='), AdminCmdBtn)
    aStroke.Color = Color3.fromRGB(255, 215, 0)
    aStroke.Thickness = 1
end

StatusLabel = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('diBYryImiQsPWdUejmwPpixlLsRaFdkqONKJofPETfhtcyWwQIkPMpjVGV4dExhYmVs'), MainFrame)
StatusLabel.Size = UDim2.new(0.68, 0, 0, 24)
StatusLabel.Position = UDim2.new(0.03, 0, 0.86, 0)
StatusLabel.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
StatusLabel.BackgroundTransparency = 0.9
StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('MVvaStOYqaCCYVkkzBCvniFGlLrvEbkDmiPafZXGRFsdNyjcvRMbJGP4Lij4Liw4Lia4Lia4Lie4Lij4LmJ4Lit4Lih4LmA4LiI4Liy4Liw4LiC4LmJ4Lit4Lih4Li54Lil4Lic4Li54LmJ4LmA4Lil4LmI4LiZLi4u')
StatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.TextWrapped = true
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BQrLKVQyElNmTPIbmNOmRptaQRQcVAXgxsSTlpnEkATRwhkdtrknChmVUlDb3JuZXI='), StatusLabel).CornerRadius = UDim.new(0, 4)

local RefreshBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hAOOMpcKoiWMRhDisOcDNehDzoqpgRJaksnJYfpuZpumNbIdsYOZAdHVGV4dEJ1dHRvbg=='), MainFrame)
RefreshBtn.Size = UDim2.new(0.24, 0, 0, 24)
RefreshBtn.Position = UDim2.new(0.73, 0, 0.86, 0)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
RefreshBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('AsjFxryQPEkbBsxeCCjHmfaiXXnSDvlLDBGjDSvHldOYddxHmZvYkis8J+UhCDguKPguLXguYDguJ/guKPguIrguKPguLLguKLguIrguLfguYjguK0=')
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.TextSize = 10
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('HNdVTOJnhTJmZmmSMorvLyjTmVFfsFNySwpVZggAkCgbYqAxStoanOuVUlDb3JuZXI='), RefreshBtn).CornerRadius = UDim.new(0, 4)

local ToggleBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('HVRXartnIcYywPAUFUvrQCZFfDGztdHCeTiiYxunwTwMQciwGvERJAdVGV4dEJ1dHRvbg=='), ScreenGui)
ToggleBtn.Size = UDim2.new(0, 46, 0, 46)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ToggleBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rMnGkRaFEvbCNsSJgDPFKEIIcZzvvZVoTBvCpwwrnDcrkBpbLZhZOCp8J+OtQ==')
ToggleBtn.TextSize = 18
ToggleBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleBtn.ZIndex = 10
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('srXkkIEAHlkvAYGhyVuupuvraSrUJwRmmfjrvxRMPstFcWKfUSHowTeVUlDb3JuZXI='), ToggleBtn).CornerRadius = UDim.new(0, 23)
local tStroke = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gkAmnzoEofndDNAyUzFthlneETRoOVKZiEORPkMvKLcUvBskGWqSzcFVUlTdHJva2U='), ToggleBtn)
tStroke.Color = Color3.fromRGB(255, 215, 0)
tStroke.Thickness = 1.5
setDrag(ToggleBtn, ToggleBtn)

-- ==================== หน้าต่างรองส่อง Real-time / ADMIN POPUP ====================
local JunkFrame = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dWPxvEpwezRTthEFwvYyzAYwqOfnlcNrCMtIlBDqeXhizVFvdVUEgRtRnJhbWU='), ScreenGui)
JunkFrame.Size = UDim2.new(0, 420, 0, 240)
JunkFrame.Position = UDim2.new(0.5, -210, 0.5, -120)
JunkFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
JunkFrame.Visible = false
JunkFrame.ZIndex = 5
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZLfzRdNskmjMDSrlOBUTUAbyyJugyeUfuPTOJpsDIpmCHxsmFfLPJbUVUlDb3JuZXI='), JunkFrame).CornerRadius = UDim.new(0, 8)
local jStroke = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TjqbBKjXpNJpPzDRmsuqqOUFiaJKVKZTJNCEacvrmQPFlBtoXgCZiDJVUlTdHJva2U='), JunkFrame)
jStroke.Color = Color3.fromRGB(140, 20, 230)
jStroke.Thickness = 1.5

local JunkTopBar = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('MslKHrzCowcDghxEXCzLpnbjafFAXhqovqKXXZWozwDbIFxNuHrEoSqRnJhbWU='), JunkFrame)
JunkTopBar.Size = UDim2.new(1, 0, 0, 32)
JunkTopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NmMsTcHsbHErzeoCvRFFbLqRqTSgsitJrXZNMqfbsCRaZMKNKeBibQsVUlDb3JuZXI='), JunkTopBar).CornerRadius = UDim.new(0, 8)
setDrag(JunkFrame, JunkTopBar)

local JunkTitle = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('HQQMyCkHvafHOhgydaOaWbmuoooqNrLbwQqfxZsVSxbhztCGeefGYhzVGV4dExhYmVs'), JunkTopBar)
JunkTitle.Size = UDim2.new(1, -10, 1, 0)
JunkTitle.Position = UDim2.new(0, 12, 0, 0)
JunkTitle.BackgroundTransparency = 1
JunkTitle.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BmHPLREmsXRbsAXnMcEABvkiMAPSSLvcKQZWrRAiszVsFRaJisCuOTmVklFV0VSIFdJTkRPVw==')
JunkTitle.TextColor3 = Color3.fromRGB(200, 100, 255)
JunkTitle.Font = Enum.Font.GothamBold
JunkTitle.TextSize = 11
JunkTitle.TextXAlignment = Enum.TextXAlignment.Left

local JunkScroll = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('fUaVHwDkICYjCyEBPnvrqNGBofCNqFelpKROyJXwwrTnCMetuLMUDUhU2Nyb2xsaW5nRnJhbWU='), JunkFrame)
JunkScroll.Size = UDim2.new(0.94, 0, 0, 150)
JunkScroll.Position = UDim2.new(0.03, 0, 0.18, 0)
JunkScroll.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
JunkScroll.BorderSizePixel = 0
JunkScroll.ScrollBarThickness = 4
JunkScroll.ScrollBarImageColor3 = Color3.fromRGB(140, 20, 230)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('GzEhDXPztsECHkPNDnvkvLAYBlbPiHEEZJqkioCyXbQFaaKTACmaJEFVUlDb3JuZXI='), JunkScroll).CornerRadius = UDim.new(0, 5)

local JunkTextLabel = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('vTpEYmwUUajdghFXuPCgHwuiocDFkfKaEISylIQsUsZGdbRFhrTQoiwVGV4dExhYmVs'), JunkScroll)
JunkTextLabel.Size = UDim2.new(1, -10, 0, 0)
JunkTextLabel.Position = UDim2.new(0, 5, 0, 5)
JunkTextLabel.BackgroundTransparency = 1
JunkTextLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('EVJYdQxgDdrHLeAgTMulWjpcdtRGqiZMytGZMKkTqDvdQTkGqYxcNKd4LmE4Lih4LmI4Lih4Li14LiC4LmJ4Lit4Lih4Li54LilLi4u')
JunkTextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
JunkTextLabel.Font = Enum.Font.Code
JunkTextLabel.TextSize = 11
JunkTextLabel.TextXAlignment = Enum.TextXAlignment.Left
JunkTextLabel.TextYAlignment = Enum.TextYAlignment.Top
JunkTextLabel.TextWrapped = true

local JunkCopyBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('IyKfeAZVyRgBOUkxKypDWEUfgNHbdUwMYwVvtWqFfdOUiHwKshpRGhbVGV4dEJ1dHRvbg=='), JunkFrame)
JunkCopyBtn.Size = UDim2.new(0.45, 0, 0, 26)
JunkCopyBtn.Position = UDim2.new(0.03, 0, 0.86, 0)
JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230)
JunkCopyBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('KlJnLxGPehnzSlvwBfWUfdeLzCVkHZoyPaoHbQUXSmuetBCYSAOglDV8J+TiyDguITguLHguJTguKXguK3guIHguJfguLHguYnguIfguKvguKHguJQ=')
JunkCopyBtn.Font = Enum.Font.GothamBold
JunkCopyBtn.TextSize = 11
JunkCopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gpYLTxCicSddEWrAXzYSsYdcOtCiLNSuZTpoUnuQbftEgiqqbxlRZVtVUlDb3JuZXI='), JunkCopyBtn).CornerRadius = UDim.new(0, 5)

local JunkBackBtn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('dLzLOayvTHjNbhkmJVHWbpMrQYGoSRvsdzUFKjPyfapSmUCJMMBCKCmVGV4dEJ1dHRvbg=='), JunkFrame)
JunkBackBtn.Size = UDim2.new(0.45, 0, 0, 26)
JunkBackBtn.Position = UDim2.new(0.52, 0, 0.86, 0)
JunkBackBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JunkBackBtn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ogwyzJvJIJuAQsueqZRGkGrQOmcQZYVhvXGjklVMLddZaIFmcBJIXoU4qyF77iPIOC4ouC5ieC4reC4meC4geC4peC4seC4mg==')
JunkBackBtn.Font = Enum.Font.GothamBold
JunkBackBtn.TextSize = 11
JunkBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CZIqViCUwwjCxIXWFRoVWTJShvDTEzewScIvrUrlTPUmPygMhbQewYGVUlDb3JuZXI='), JunkBackBtn).CornerRadius = UDim.new(0, 5)

local CurrentViewMode = 1
local PlayerButtons = {}

local function refreshPlayers()
    if not ListScroll or not ListScroll:IsDescendantOf(game) then return end
    
    local currentPlayers = Players:GetPlayers()
    local activeMap = {}

    for _, p in ipairs(currentPlayers) do
        if p ~= LocalPlayer then
            activeMap[p] = true
            local btn = PlayerButtons[p]
            if not btn then
                btn = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('zgoaaHvyksljTlTgVpEvZPKZwEUBkOBWJAiqPfSJcZImQOikgiSJPuJVGV4dEJ1dHRvbg=='), ListScroll)
                btn.Size = UDim2.new(1, -6, 0, 28)
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 11
                btn.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FwyYdHzRQfcPubbnKUVDmwqypAMLNgHeSpTgKiYJUiIEvWKFinJUqYgVUlDb3JuZXI='), btn).CornerRadius = UDim.new(0, 4)
                local bStroke = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hqupkSjaucKpUxREHFlDzClWOUylEaRfJPKqBbsPOaOOhKziXCZZswFVUlTdHJva2U='), btn)
                bStroke.Color = Color3.fromRGB(40, 40, 40)

                btn.MouseButton1Click:Connect(function()
                    for playerObj, b in pairs(PlayerButtons) do
                        if b:FindFirstChildOfClass(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('olFjPPiNaajkeVMeJfsfImYiXfJvjxQVfAixrsYiUvXZsEfTKjqtmASVUlTdHJva2U=')) then
                            b.UIStroke.Color = Color3.fromRGB(40, 40, 40)
                        end
                    end
                    bStroke.Color = Color3.fromRGB(255, 215, 0)
                    CurrentSelectedPlayer = p
                    StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('KVZiuwFvBgzItphPPnkSVWqhUvppihvTTKRYzaznrcVLRdSROciHDvz4LmA4Lil4Li34Lit4LiBOiA=') .. p.DisplayName
                    updateJunkViewerLive()
                end)
                PlayerButtons[p] = btn
            end

            local activeSounds = checkPlayerAllSounds(p)
            if #activeSounds > 0 then
                btn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('mUrHxAmwugSDpCxcPSrdsvSTzgcTrPoePOaIVsffKWVJHhyBbKIKJvsIPCfjrUg') .. p.DisplayName .. iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('PRRJhfoWxqsMTBOxZDuqmpvLdOEsElztKlGGADzIYQeVHFFhxIqliYsIChA') .. p.Name .. iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('xVYADFSEWdJZokaxyGPxdWvjqHHlMBHVzSjAVqmNKKlsyyPKqTgvkcEKQ==')
                btn.TextColor3 = Color3.fromRGB(0, 255, 0)
            else
                btn.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('AzVDjKnghEpqHxMYilyphkPblFKxvuHqLdhEmujiOoDcTehCliUamSbIPCfkaQg') .. p.DisplayName .. iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LtSfsowjLMNybEztcbcvmBvQJBvlMawQhjEIOvUYgglWbfdUNujyFCDIChA') .. p.Name .. iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('aKgLGuQndhWsPHfLMgfViaCvMSyDkRJlNkeZGcoVswxAOpFBsnOVmkJKQ==')
                btn.TextColor3 = Color3.fromRGB(230, 230, 230)
            end

            if CurrentSelectedPlayer == p then
                btn.UIStroke.Color = Color3.fromRGB(255, 215, 0)
            end
        end
    end

    for p, btn in pairs(PlayerButtons) do
        if not activeMap[p] then
            btn:Destroy()
            PlayerButtons[p] = nil
        end
    end

    ListScroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
end

function updateJunkViewerLive()
    if not JunkFrame.Visible then return end

    local outputText = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('zPjsyyRUZwgNnIRgXxiKrObDRcOkBofALOhlMVcrBfJrSPrbUJPzlWp')

    if CurrentSelectedPlayer and CurrentViewMode ~= 3 then
        local targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name)
        if not targetPlayer then return end
        
        local soundObjects = checkPlayerAllSounds(targetPlayer)

        if CurrentViewMode == 1 then
            JunkTitle.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('wSpcrbOXRXiBXlIJnElgEylsifQxdYLGSAIOJcyNeuKZbeEYdeoKxbjUkFXIEpVTksgVklFV0VSICjguILguKLguLDguJTguLTguJrguJfguLHguYnguIfguKvguKHguJQgMTAwJSk=')
            jStroke.Color = Color3.fromRGB(140, 20, 230)
            JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230)
            
            if #soundObjects == 0 then 
                outputText = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('IFEpWStiFPMNRikDYdmBxAneAfambMSWybSvPbUTxLdzoUrCCHHDebt4p2MIOC5hOC4oeC5iOC4nuC4muC4reC4reC4muC5gOC4iOC4geC4leC5jOC5gOC4quC4teC4ouC4h+C4muC4meC4leC4seC4p+C4nOC4ueC5ieC5gOC4peC5iOC4meC4meC4teC5iQ==')
            else
                for i, obj in ipairs(soundObjects) do
                    outputText = outputText .. string.format(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('IpjlGhapWzvZfFRdGrmuzsOcVIIYiKqZgZUUbWhFabChxWIAUUcQgtQWyVkXSDguK3guK3guJrguYDguIjguIHguJXguYw6ICVzXG5JRCDguJTguLHguYnguIfguYDguJTguLTguKE6ICVzXG5cbg=='), i, obj:GetFullName(), obj.SoundId)
                end
            end
        elseif CurrentViewMode == 2 then
            JunkTitle.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NUKDuYJrXwaRkDxHKgDucMjdGQfASdNVYjqubwiVCuikckecYolyBYQSU5TVEFOVCBMT0cgVklFV0VSIChJRCDguYDguIjguLLguLDguKrguJTguYDguKPguLXguKLguKXguYTguJfguKHguYwp')
            jStroke.Color = Color3.fromRGB(0, 200, 100)
            JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            
            if #soundObjects == 0 then
                outputText = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('DehjspCknlTGipmdslgDHCzzcUEqjcRukiCVrJLMAzQsAjdcSHWPYJD4p2MIOC5hOC4oeC5iOC4nuC4muC4hOC5iOC4suC4leC4seC4p+C5geC4m+C4o+C5gOC4nuC4peC4h+C4guC4reC4h+C4nOC4ueC5ieC5gOC4peC5iOC4meC4meC4teC5iQ==')
            else
                local finalIds = {}
                local seenIds = {}
                for _, soundObj in ipairs(soundObjects) do
                    local rawId = soundObj.SoundId or iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('SxIpPuyoCFMZyDzNELVCVEKuXeSciRlyulLQMSMtfTGYVImxlBnpoIh')
                    local decoded = deepDecode(rawId)
                    local searchText = (decoded ~= iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('wbSIVEJDUHKDAgKUUQxVkRdAWdoGXFsNKntxRAjfIYthrQnlXMZWpZY') and decoded) or rawId

                    local extractedIds = extractIDsFromPattern(searchText)
                    if #extractedIds == 0 then
                        for num in string.gmatch(searchText, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RqRxqVetFkQbdDYJjmFNxiznUQIJLlMSxRiprAWdAzwQCpqjnqWGJlNJWQr')) do
                            if not BlockedIDs[num] then table.insert(extractedIds, num) end
                        end
                    end

                    for _, id in 
     ipairs(extractedIds) do
                        if not seenIds[id] then
                            seenIds[id] = true
                            table.insert(finalIds, id)
                        end
                    end
                end
                
                if #finalIds == 0 then
                    outputText = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('fppwMdbstyPQppOzuCvrzCGtVGXFzaHpJGQIwirWFDRfrScbwEVMBQz4p2MIOC4lOC4tuC4h+C4hOC5iOC4suC5geC4peC5ieC4p+C5hOC4oeC5iOC4nuC4miBJRCDguYDguJ7guKXguIfguIjguKPguLTguIfguK3guKLguLnguYjguILguYnguLLguIfguYPguJnguYDguKXguKIgKOC5guC4lOC4meC4muC4peC5h+C4reC4geC4l+C4seC5ieC4h+C4q+C4oeC4lCk=')
                else
                    outputText = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('iFdRzYYCgQAkrcKnAvnuBBiPHNgzOXLZDYaHWnXESoqipFFlpNBRwtMLS0tIOC4nuC4muC4muC4l+C5gOC4nuC4peC4h+C5gOC4iOC4suC4sOC4quC4s+C5gOC4o+C5h+C4iOC4l+C4seC5ieC4h+C4q+C4oeC4lCA=') .. #finalIds .. iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CENRIRswPDXqdtAGonUuZHyGkMwxdArDvlGMpwLzwJlWNVdhkhWomxsIElEIC0tLVxuXG4=')
                    for idx, id in ipairs(finalIds) do
                        outputText = outputText .. string.format(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('grDthqzgwsWWmIFEGcrrIidTlcBBMcRbeMFvWuKqXYbBWfMxOlgrXPdWyVkXSBJRCDguYDguIjguLLguLDguYTguJTguYk6ICVzXG4='), idx, id)
                    end
                end
            end
        end
    elseif CurrentViewMode == 3 then
        JunkTitle.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('fBvDfKUguAbTZXQdfQjtiKStBmgHwslzJdTHxTvJmsZBusGvPjVLMvd8J+RkSBBRE1JTiBDT01NQU5EUyBMSVNUIChA') .. AdminUsername .. iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('pjPybSqctWPAAmiMvTZidzshAXPKQsYQzfRsLAWJFZxwFmDzORxrLMXKQ==')
        jStroke.Color = Color3.fromRGB(180, 0, 255)
        JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
        outputText = [[👑 รายชื่อคำสั่งแชทแกล้งคน (พิมพ์ในช่องแชทได้เลย คนอื่นจะไม่เห็นข้อความ):

;check - เช็กคนรันสคริปต์ (ขึ้น Highlight สีเขียวบนหัว 2 วินาที)
;kill [ชื่อ] - ฆ่าผู้เล่น
;freeze [ชื่อ] - แช่แข็งผู้เล่น
;unfreeze [ชื่อ] - ปลดแช่แข็ง
;bring [ชื่อ] - ดึงผู้เล่นมาหาเรา
;tp [ชื่อ] - วาร์ปไปหาผู้เล่น
;void [ชื่อ] - ส่งผู้เล่นลงใต้แมพ (ตกโลก)
;fling [ชื่อ] - ดีดผู้เล่นให้กระเด็น
;jumpscare [ชื่อ] - หลอกผีผู้เล่น
;banscript [ชื่อ] - แบนออกจากสคริปต์ถาวร (ลบ UI ทิ้ง)]]
    end

    if JunkTextLabel.Text ~= outputText then
        JunkTextLabel.Text = outputText
        local textBounds = 
  TextService:GetTextSize(outputText, 11, Enum.Font.Code, Vector2.new(JunkScroll.AbsoluteSize.X - 15, math.huge))
        JunkTextLabel.Size = UDim2.new(1, -10, 0, textBounds.Y + 20)
        JunkScroll.CanvasSize = UDim2.new(0, 0, 0, textBounds.Y + 40)
    end
end

GetIDBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('uYFsrTikFEnmTytNHjuzWXxOiSCaOmTqbLuhhZKdhPyQqFrFtjpukwD8J+UjSDguIHguLPguKXguLHguIfguYDguIjguLLguLDguYHguKXguLDguJrguLHguJnguJfguLbguIEgSUQg4LiX4Lix4LmJ4LiH4Lir4Lih4LiULi4u')
        local targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name)
        local soundObjects = checkPlayerAllSounds(targetPlayer)
        local finalIds = {}
        local seenIds = {}
        for _, soundObj in ipairs(soundObjects) do
            local rawId = soundObj.SoundId or iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NbFQqxCGtLlzUFakUyMgkLDjAsogPjAChyYovhBRzdxPCTPkiwQvnve')
            local decoded = deepDecode(rawId)
            local searchText = (decoded ~= iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('QbWfUOWPylTSqvNXmQmsMZWRszbjsYqWacmpHXDpllRLNUrvgqZepZX') and decoded) or rawId
            local extractedIds = extractIDsFromPattern(searchText)
            if #extractedIds == 0 then
                for num in string.gmatch(searchText, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('GZYFCWlrzTQoGhjVOcOCWELjQQgabeAxUiZwWanCYnRPMoyQKulwyUnJWQr')) do
                    if not BlockedIDs[num] then table.insert(extractedIds, num) end
                end
            end
            for _, id in ipairs(extractedIds) do
                if not seenIds[id] then
                    seenIds[id] = true
                    table.insert(finalIds, id)
                end
            end
        end
        if #finalIds > 0 then
    copyToClipboard(table.concat(finalIds, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('nrHxfbGkwjUFFehmlumZMUMUUdfmYHENncsfwEvsqTpqMFGDXEFBcqMIA==')))
            StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rqywEOpqAOrbrMYZTPfwpUCSVHvTjQsnLOAaeoClmzQqHoKagvphMiT8J+TiyDguITguLHguJTguKXguK3guIEg') .. #finalIds .. iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('bHfcVCawugAmPVkavcIQpMePpwMWXlYxURPgkaOZxtJhYzyzHeIqlBuIElEIOC5gOC4o+C4teC4ouC4muC4o+C5ieC4reC4oiE=')
        else
            StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('MBzhCZvFhcSWdqSZqKEhpYQjBdDJWrzbfSVoUXITBLGNUrfgHOHAqxu4p2MIOC5hOC4oeC5iOC4nuC4miBJRCDguJfguLXguYjguYPguIrguYnguYTguJTguYk=')
        end
    else
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('HtAlUZdAdJyFICaKjcFnZtPQjDdOOymseoHEZXcvEjNLKFFXevDfJbQ4pqg77iPIOC5guC4m+C4o+C4lOC5gOC4peC4t+C4reC4geC4iuC4t+C5iOC4reC4nOC4ueC5ieC5gOC4peC5iOC4meC4geC5iOC4reC4meC4geC4lOC4lOC4tuC4hyE=')
    end
end)

GetJunkBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('OrkzOVVKGNPNEBrkssaaGIcYAOGUZvCRRGwHGtGTYaCwWcxLRgmthMP8J+OtSDguIHguLPguKXguLHguIfguKLguLTguIfguITguLPguKrguLHguYjguIfguYDguJvguLTguJTguYDguJ7guKXguIfguJXguLLguKHguILguKLguLAuLi4=')
        local targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name)
        local soundObjects = checkPlayerAllSounds(targetPlayer)
        local firstCleanId = nil
        for _, soundObj in ipairs(soundObjects) do
            local rawId = soundObj.SoundId or iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('OwevZaeBmwoEXtfbxBNehvMiYMfUxPLBpzSmBdhiewPtJtZkrCGnUbI')
            local cleanId = string.gsub(rawId, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('INvhFxDphOGhHfsoqmlPcFxRiXgwDLhEdxjLqlDswpPnNmQMDQBioUTXnJieGFzc2V0aWQ6Ly8='), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rzvhovTKRnXRvEqejyKdDXsDLuuaxACfVxPLaBnuIKdoLYULYBOhoIp'))
            if string.find(cleanId, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('aWVhBPOuvLoczvkEXxlMcZonAvKxePFLMjzfwnxquRMSCUtBAeJLnmzcmJ4YXNzZXRpZDovLw==')) then
                cleanId = string.match(cleanId, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('IudEVfAtjpIWFiLaLzaelHPkWYDkPjFRXiHdVnuSNTqVSFoEJkiwQSdcmJ4YXNzZXRpZDovLyglZCsp')) or cleanId
            end
            if not BlockedIDs[cleanId] and cleanId ~= iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('BGWPmmJsiwIFAawSjHkIfEZEIIxTgpcHsZJPvBbTLXJiJfZRZsFWYuV') then
                firstCleanId = cleanId
                break
            end
        end
        if firstCleanId and playMusicFromId(firstCleanId) then
            StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('yPzcEUJwNLMZFtgdlEcgdMaBLrUzYyUAZLLhTDvFnppIUbXbgDDzNPs4pyFIOC5gOC4m+C4tOC4lOC5gOC4nuC4peC4h+C4quC4s+C5gOC4o+C5h+C4iDog') .. firstCleanId
        else
            StatusLabel.Text = 
    iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('UAczuiPlvOjAhzdUNoyIacIoSNbDfJpVaaePvVoTcopCweXdKmxaYcl4p2MIOC5gOC4peC5iOC4meC5gOC4nuC4peC4h+C5hOC4oeC5iOC4quC4s+C5gOC4o+C5h+C4iCDguKvguKPguLfguK3guYLguJTguJnguJrguKXguYfguK3guIE=')
        end
    else
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('vytHURoNORoAnTkRVMEGUhXflyrrUeRUwmmIbgBbTBwmEgJpBqyiBPz4pqg77iPIOC5guC4m+C4o+C4lOC5gOC4peC4t+C4reC4geC4iuC4t+C5iOC4reC4nOC4ueC5ieC5gOC4peC5iOC4meC4geC5iOC4reC4meC5gOC4m+C4tOC4lOC5gOC4nuC4peC4hyE=')
    end
end)

ViewRawJunkBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        CurrentViewMode = 1
        JunkFrame.Visible = true
        updateJunkViewerLive()
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LJrJhVYRGJHaaPmVEWJTOcfZRYKjAkILfrPjxdSTKugAufbaEhVexYX8J+Rge+4jyDguYDguJvguLTguJTguKvguJnguYnguLLguJXguYjguLLguIfguYHguKrguJTguIfguILguKLguLAgUkFXIOC5gOC4o+C4teC4ouC4peC5hOC4l+C4oeC5jOC5geC4peC5ieC4pw==')
    else
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZdTxKVpqCfcgnKakSNhONwIsMYnYfdJpgvxsNZJfLOjllOqWRktQPFf4pqg77iPIOC5guC4m+C4o+C4lOC5gOC4peC4t+C4reC4geC4iuC4t+C5iOC4reC4nOC4ueC5ieC5gOC4peC5iOC4meC4geC5iOC4reC4meC4geC4lOC4lOC4ueC4guC4ouC4sOC4lOC4tOC4miE=')
    end
end)

ViewInstantBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        CurrentViewMode = 2
        JunkFrame.Visible = true
        updateJunkViewerLive()
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FFTOUEYtBiQCMzuvsczomlWKKNFdKCDEYZqSnmsohLfOOLQcgRbCzpW8J+UjSDguYDguJvguLTguJTguKvguJnguYnguLLguJXguYjguLLguIfguKrguYHguIHguJkgSUQg4LmA4LiI4Liy4Liw4Liq4LiUIFJlYWwtdGltZQ==')
    else
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('mUnxMNgvnPDzRLlJsmFEDYuKmMWOCSVQrTBIyJJjfykFUdUwnWrWtrI4pqg77iPIOC5guC4m+C4o+C4lOC5gOC4peC4t+C4reC4geC4iuC4t+C5iOC4reC4nOC4ueC5ieC5gOC4peC5iOC4meC4geC5iOC4reC4meC4geC4lOC4lOC4uSBJRCDguYDguIjguLLguLDguKrguJQh')
    end
end)

if AdminCmdBtn then
    AdminCmdBtn.MouseButton1Click:Connect(function()
        CurrentViewMode = 3
        JunkFrame.Visible = true
        updateJunkViewerLive()
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('sMDIWPxSJLleFJbWqENfVaslPkNufmCVRfmlInlQiVREuppVynOoEdz8J+RkSDguYDguJvguLTguJTguKvguJnguYnguLLguJXguYjguLLguIfguITguLPguKrguLHguYjguIcgQURNSU4g4LmA4Lij4Li14Lii4Lia4Lij4LmJ4Lit4Lii4LmB4Lil4LmJ4Lin')
    end)
end

JunkCopyBtn.MouseButton1Click:Connect(function()
    if JunkTextLabel.Text ~= iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('JyAVyoYjKmzxKATGnibTQLhARMjBAyAbjhEXOpUzfNOEKOqWqcZdKCE4LmE4Lih4LmI4Lih4Li14LiC4LmJ4Lit4Lih4Li54LilLi4u') and not string.find(JunkTextLabel.Text, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hSbEhDKEIUVwrWHnWGpJSEnSehJVtBtQRnHrilVAxMBICLuytIjdDlw4p2M')) then
        copyToClipboard(JunkTextLabel.Text)
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('AWcCqzUiCrMSSumZnoTKwNbKYOFtcdMxHyOdkINjowJpgGLDAsqTees8J+TiyDguITguLHguJTguKXguK3guIHguYDguJnguLfguYnguK3guKvguLLguJfguLHguYnguIfguKvguKHguJTguYDguKPguLXguKLguJrguKPguYnguK3guKIh')
    end
end)

JunkBackBtn.MouseButton1Click:Connect(function()
    JunkFrame.Visible = false
    StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('roxpEykWHNQjFwuVPepRVtrCFiLARSyZbGuCifpnxQLOCjBiYfZsjyw4qyF77iPIOC4geC4peC4seC4muC4quC4ueC5iOC5geC4nOC4h+C4hOC4p+C4muC4hOC4uOC4oeC4q+C4peC4seC4geC5geC4meC4p+C4meC4reC4meC5geC4peC5ieC4pw==')
end)

RefreshBtn.MouseButton1Click:Connect(refreshPlayers)

Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(function(p)
    if CurrentSelectedPlayer == p then
        CurrentSelectedPlayer = nil
        StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('jJfOkkFIqsDYcBIQdrTAJIdQVmaFDfCgkYmgnZeplFZSTGYdNVRpcmE4LmC4Lib4Lij4LiU4LmA4Lil4Li34Lit4LiB4Lic4Li54LmJ4LmA4Lil4LmI4LiZLi4u')
    end
    refreshPlayers()
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if not MainFrame.Visible then 
        JunkFrame.Visible = false 
    else
        refreshPlayers()
    end
end)

task.spawn(function()
    while true do
        task.wait(1.5)
        if MainFrame.Visible then
            pcall(function()
                refreshPlayers()
                if JunkFrame.Visible then
                    updateJunkViewerLive()
                end
            end)
        end
    end
end)

refreshPlayers()

-- =====================================================
-- 🟢 VISUAL CHECK TRACKER SYSTEM (;check HIGHLIGHT)
-- =====================================================

local TrackerEvent = ReplicatedStorage:FindFirstChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('YCtgcVbGIPsoArcxfbaauReKSyFOOTvMUXarPvTUeSfYchKvrrPyJFOSG9uU2NyaXB0VHJhY2tlckV2ZW50'))
if not TrackerEvent then
    TrackerEvent = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('fPrIAUhkKFQcNBeyJRGkwbzWlfftZZxfDxvgJjoXyfIeayWxQEDvmjxQmluZGFibGVFdmVudA=='))
    TrackerEvent.Name = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RusoPAqNnUtoVAVrRBqvpiWnXStGtEFmsIYWgxYSZLAHNyCkNwRrhzSSG9uU2NyaXB0VHJhY2tlckV2ZW50')
    TrackerEvent.Parent = ReplicatedStorage
end

local function ShowVisualEffect(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local char = targetPlayer.Character
    local head = char:FindFirstChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LDqsUjUTZLuSAwZZeoHLiqfbcDBILvClFwdTuuUZNfqHRiQnqLKeQDySGVhZA==')) or char.PrimaryPart
    if not head then return end

    -- สร้าง Highlight สีเขียว
    local highlight = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('lMgcYgHcokUSQdKnPWxCCOazqQDTwJmILBPTBkBaDYmrvuYOSFUSmTDSGlnaGxpZ2h0'))
    highlight.Name = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NvybSaSQgRUoJCfLbcKZJZtCwdmWJavisofYBnUjJnTUgFgwlBWsNMVU2NyaXB0VXNlckhpZ2hsaWdodA==')
    highlight.FillColor = Color3.fromRGB(0, 255, 100)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.3
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char

    -- สร้างป้ายข้อความบนหัว
    local billboard = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('nIKknutMqvAggipQSUBewleGiBzqWSFDzuQoPsLDjNMveoCInkCxNBiQmlsbGJvYXJkR3Vp'))
    billboard.Name = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('HeRtDijnqgNpSbaymwvnJSLRGGgCQZniglOIUVHOrxknCaSnFeGCNcxU2NyaXB0VXNlclRhZw==')
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local label = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('suoltdpUgiwXUSSdRZNHXahrVZAOHRJAtXXDqRnYFaGqRjnSxpwKAJIVGV4dExhYmVs'))
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('eklugEFWIEeArjnluGocPkDHNmcixSLGIJpOeBnPXiTUMPmePOQhZTd8J+foiBSVU5OSU5HIFNDUklQVDog') .. targetPlayer.Name
    label.TextColor3 = Color3.fromRGB(0, 255, 120)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.FredokaOne
    label.TextSize = 18
    label.Parent = billboard

    -- หายไปใน 2 วินาที
    task.delay(2, function()
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local t1 = TweenService:Create(highlight, tweenInfo, {FillTransparency = 1, OutlineTransparency = 1})
        local t2 = TweenService:Create(label, tweenInfo, {TextTransparency = 1, TextStrokeTransparency = 1})
        
        t1:Play()
        t2:Play()
        
        t1.Completed:Connect(function()
            highlight:Destroy()
            billboard:Destroy()
        end)
    end)
end

TrackerEvent.Event:Connect(function(action, senderName)
    if action == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('TQqqPWJWidQOnTIwGxbyDKudkHBpTIzfhLJEssqxxXVHKKcSdnAcahvUGluZ0NoZWNr') and senderName ~= LocalPlayer.Name then
        TrackerEvent:Fire(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('qGfJoRfdkHuetGfjkMWWNkCcvLuzYimgbYDNzrdqrWZMcyuyJagzrUpUG9uZ1Jlc3BvbnNl'), LocalPlayer.Name, senderName)
    elseif action == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('jEasnrZzHlxRQwWGcxyTIkCtevArbLyKAvIMVJzZGFgZsEeEdsvJjUEUG9uZ1Jlc3BvbnNl') and senderName then
        local p = Players:FindFirstChild(senderName)
        if p then ShowVisualEffect(p) end
    end
end)

local function PingAllUsers()
    ShowVisualEffect(LocalPlayer)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            pcall(function()
                TrackerEvent:Fire(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ZWTGjRvzSnkEClRQkWcQRGWnIlZRHnvUzIBWOafWbkklBolKQsFEHGyUGluZ0NoZWNr'), LocalPlayer.Name)
            end)
        end
    end
end

-- =====================================================
-- ⚙️ ADMIN COMMAND EXECUTION & CHAT INTERCEPTOR
-- =====================================================

local function ExecuteAdminCommand(cmd, targetArg)
    local targetPlayer = findTargetPlayer(targetArg)
    
    if cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('mZMaFntmKOKYPDvZrEHaHzlclFDtVClIOhUOVEUTRtzcKDKnxobMzNSYmFuc2NyaXB0') then
        if targetPlayer then
            BannedFromScript[targetPlayer.UserId] = true
            BannedFromScript[targetPlayer.Name:lower()] = true
            StatusLabel.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('rKiHAEisDITdfNNHDDyWhtWnxOGVjtUumdPVbZKOSwhwKwcWGMbNTxB8J+aqyDguYHguJrguJkg') .. targetPlayer.Name .. iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ltpLBgFcyTlCevzHYiQbLOcMLuOroRawVCECIUDnKXSeAZuEbNTqIOyIOC4reC4reC4geC4iOC4suC4geC4quC4hOC4o+C4tOC4m+C4leC5jOC5gOC4o+C4teC4ouC4muC4o+C5ieC4reC4oiE=')
        end
        return
    end

    if targetPlayer and targetPlayer == LocalPlayer then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('QYWmnaGZEoLynCByOlqstmrUpPFcUdixrpwvCklVunavYEUJJBkjomLSHVtYW5vaWQ='))
        local hrp = char and char:FindFirstChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ePTHYxWDvljxFuuqaspFaBpXIxEtJdFkgiewWWyUtKZTUPkUZvEEpxNSHVtYW5vaWRSb290UGFydA=='))

        if cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('CzVchFxaHkCtFTeYCRXQdxRTuwxymOMjqYbHYysVwBgWTqjSZncsAQBa2lsbA==') then
            if hum then hum.Health = 0 end
        elseif cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('XlRNfiKwZDjzpomMSnDTVDUBKVRnqZiQIEBTMssRrsCZAhvOZNUFBbIZnJlZXpl') then
            if hrp then hrp.Anchored = true end
        elseif cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('FKxTfKJuuyeVWRSQzDFPNLLhUWjwzLSOqOGPuvdhXmVLpXgaEZfdfNgdW5mcmVlemU=') then
            if hrp then hrp.Anchored = false end
        elseif cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('QuuvPFqfdWkNMDmEdNAlRSmiMKyIaMnmisSpJgKXqAKOcDRUPSiOPzpYnJpbmc=') then
            local adminPlayer = Players:FindFirstChild(AdminUsername)
            if adminPlayer and adminPlayer.Character and adminPlayer.Character:FindFirstChild(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('LVoChZcMIVVamINnKqHEcvoCgbnKnqyPNkxxfmlMsCtmVSNxEAPRDwxSHVtYW5vaWRSb290UGFydA==')) and hrp then
                hrp.CFrame = adminPlayer.Character.HumanoidRootPart.CFrame
            end
        elseif cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('fhgOHnzYyJeBWkBjtNGlHRsXCQEXxnULQtyMXnaRgulMCzwlBHmosEWdHA=') then
            -- สั่งให้ Admin วาร์ปไปหา Target
        elseif cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('RpaWBgOGRxBHBAsRjNMsLGwSQlpvoNBtWSvngvPgmOAPRFXtixeUXDfdm9pZA==') then
            if hrp then hrp.CFrame = hrp.CFrame * CFrame.new(0, -500, 0) end
        elseif cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('PgrOLuHeEtmvAfSknddjzGWvRoGEjjQzvVvaoIBTsvnVSwoxEPcTFQVZmxpbmc=') then
            if hrp then
                local bfv = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('HwPWmYFgwSsnTYvFsYYXOFfczpYNwmyFaLEolbkuDZJAiqLbJjMGbQIQm9keVZlbG9jaXR5'), hrp)
                bfv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                bfv.Velocity = Vector3.new(math.random(-500, 500), 1000, math.random(-500, 500))
                task.delay(0.5, function() bfv:Destroy() end)
            end
        elseif cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('ipDtXuwCJzcKAOoRAmSuEiANpjgwzKTGaBYAdKJMkyIeEMdbFdNqzPDanVtcHNjYXJl') then
            local jScreen = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('MdFZdrRrIhzcTVLkSdCtGZZbIKqXIBEvIgQrDVNwvrFDDcypiieyupSU2NyZWVuR3Vp'), PlayerGui)
            jScreen.Name = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('YveceMCabUNrBYqJeKXqVrcKazGwXLoFmQgWTKDjiajBVbtyGvsrKCASnVtcHNjYXJlVUk=')
            local img = Instance.new(iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('pdrqxxtvHQmNROGfVhMKVkILtaETMpKrIuzKJqENluhuFJJUCzsdTwdSW1hZ2VMYWJlbA=='), jScreen)
            img.Size = UDim2.new(1, 0, 1, 0)
            img.Image = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('AQkKsrkukxPgzNztYtoqlNWobmLjWyffdhWiqqsUILjYbTNufxYHcXlcmJ4YXNzZXRpZDovLzYwMjI4MDI4Nzk=') -- รูปภาพ Jumpscare
            task.delay(1.5, function() jScreen:Destroy() end)
        end
    end
end

-- ดักจับคำสั่งในแชท (Chat Interceptor)
local function ProcessChatMessage(message, senderPlayer)
    if not message then return false end
    local cleanMsg = string.match(message, iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('gqFQfUnfpRToddwFBecWwtuhIVGrelALEVsHRKkchEmztIhHcfDOpSlXiVzKiguLSklcyok')) or message
    
    -- เช็กคำสั่ง ;check สำหรับทุกคนที่รันสคริปต์
    if string.lower(cleanMsg) == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('eASrzXQSfGxGKkiZFIGxBvKyftzbkUvLODmXzUTQdKGaPUCKmFxHlutO2NoZWNr') and senderPlayer == LocalPlayer then
        PingAllUsers()
        return true
    end

    if cleanMsg:sub(1, 1) == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('JDRlkECAwqrhrigvIjuKlGhHefRpRuqlNQUSoJmIFnakXIQXFVDACkHOw==') then
        local args = string.split(cleanMsg:sub(2), iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('NejOcIjYUdAkbjbLcJDLSHkWXdvEnSIyjfPxFUSPaDLIfCqsSTdzCqRIA=='))
        local cmd = args[1] and args[1]:lower()
        local targetName = args[2]

        -- เช็คการแบนสคริปต์
        if cmd == iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('MTzbpdDVXEzHdUijzNoptNRpSvkNxeCXIBolIQdBfMPxGbNtLttzlsCYmFuc2NyaXB0') and senderPlayer.Name:lower() == AdminUsername:lower() and targetName then
            local targetPlayer = findTargetPlayer(targetName)
            if targetPlayer and targetPlayer == LocalPlayer then
                ScreenGui:Destroy()
                return true
            end
        end

        if senderPlayer.Name:lower() == AdminUsername:lower() then
            ExecuteAdminCommand(cmd, targetName)
            return true -- คืนค่า true เพื่อบล็อกไม่ให้แชทเด้งลงเกม
        end
    end
    return false
end

-- Hook เข้ากับระบบ Chat ของ Roblox (รองรับทั้ง Chat เก่าและ TextChatService ใหม่)
pcall(function()
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.OnIncomingMessage = function(message)
            if message.TextSource then
                local sender = Players:GetPlayerByUserId(message.TextSource.UserId)
                if sender and ProcessChatMessage(message.Text, sender) and sender == LocalPlayer then
                    message.Text = iiBAkKVswvjnVMVfGATpCHVxBaIgMmDjlGqCQOubjknKNnKOoLlvLrssICvNIUznhglvYdobpCczN('hTTiYPApFlWNCQiZrwkMvHPCNDSryRhjPFkUoVmVYkbUUjTgxIgNKPD') -- ซ่อนแชทไม่ให้โชว์ที่จอเรา
                end
            end
        end
    end
end)

-- Hook Chat ระบบเก่า (Legacy Chat System)
pcall(function()
    for _, p in ipairs(Players:GetPlayers()) do
        p.Chatted:Connect(function(msg)
            ProcessChatMessage(msg, p)
        end)
    end
    Players.PlayerAdded:Connect(function(p)
        p.Chatted:Connect(function(msg)
            ProcessChatMessage(msg, p)
        end)
    end)
end)

-- เช็คว่าตัวเราเองโดนแบนอยู่ก่อนรันไหม
if BannedFromScript[LocalPlayer.UserId] or BannedFromScript[LocalPlayer.Name:lower()] then
    ScreenGui:Destroy()
end
