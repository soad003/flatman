json.already_registred           @return.already_registred

if @return.already_registred
    json.user do
        json.(@return.user , :id, :name)
    end
else
    json.invite do
        json.(@return.invite , :id, :email)
    end
end
