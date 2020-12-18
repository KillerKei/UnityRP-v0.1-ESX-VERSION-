RegisterServerEvent("clothing:getCharactersAndClothes")
AddEventHandler("clothing:getCharactersAndClothes", function()
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local cid = TriggerClientEvent('updatecid', src, GetPlayerIdentifiers(src)[1])
    Characters = {}
    local chars = exports.ghmattimysql:executeSync("SELECT * FROM users WHERE identifier = @id ORDER BY identifier ASC", {['id'] = identifier})
    if not chars or not chars[1] then
        TriggerClientEvent("urp-login:setupChars", src, false)
    else
        for k, v in pairs(chars) do
            local i = #Characters + 1
            Characters[i] = {
                cid = cid,
                charactername = v.firstname .. " " .. v.lastname,
                dob = v.dateofbirth,
                sex = v.sex,
                height = v.height,
                cash = v.money,
                bank = v.bank,
                job = v.job
            }

            myoutfit = exports.ghmattimysql:executeSync("SELECT * FROM characters WHERE cid = @id", {['id'] = cid})
            if myoutfit[1] then
                Characters[i].outfit = {
                    model = myoutfit[1].model,
                    drawables = json.decode(myoutfit[1].drawables),
                    props = json.decode(myoutfit[1].props),
                    drawtextures = json.decode(myoutfit[1].drawtextures),
                    proptextures = json.decode(myoutfit[1].proptextures),
                }
            else
                Characters[i].outfit = {
                    model = 1885233650,
                    drawables = false,
                    props = false,
                    drawtextures = false,
                    proptextures = false,
                }
            end

            local model = myoutfit[1] and tonumber(myoutfit[1].model) or 1885233650
            if myoutfit[1] and (model == 1885233650 or model == -1667301416) then
                local faceFeatures = exports.ghmattimysql:executeSync("SELECT cc.model, cf.hairColor, cf.headBlend, cf.headOverlay, cf.headStructure FROM character_face cf INNER JOIN character_current cc on cc.cid = cf.cid WHERE cf.cid = @cid", {['cid'] = cid})
                Characters[i].face = {
                    hairColor = json.decode(faceFeatures[1].hairColor),
                    headBlend = json.decode(faceFeatures[1].headBlend),
                    headOverlay = json.decode(faceFeatures[1].headOverlay),
                    headStructure = json.decode(faceFeatures[1].headStructure),
                }
            else
                Characters[i].face = false
            end
        end
        TriggerClientEvent("urp-login:setupChars", src, Characters)
    end
end)