def individual_serial(user_reg)-> dict:
    return{
        "uid": user_reg["uid"],
        "username": user_reg["username"],
        "password": user_reg["password"],
        "confirm_pass": user_reg["confirm_pass"]
    }

def List_serial(users_reg)->list:
    return [individual_serial(user_reg) for user_reg in users_reg]



