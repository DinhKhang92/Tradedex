import cv2
import glob
import os
from PIL import Image
import Image
import sys

import json


class GamemasterImageCrawler:
    def __init__(self):
        self.source_image = ' '

        self.check_dir_existence()
        print("All directories found.")
        self.crawl_and_process_images()
        print("pokemon_icons_all created.")
        self.crawl_blank_pokemon()
        print("pokemon_icons_blank created.")
        self.crawl_shiny_pokemon()
        print("pokemon_icons_shiny created.")
        self.crawl_alolan_pokemon()
        print("pokemon_icons_alolan created.")
        self.crawl_unown_pokemon()
        print("pokemon_icons_unown created.")
        self.crawl_event_pokemon()
        print("pokemon_icons_event created.")
        self.crawl_galarian_pokemon()
        print("pokemon_icons_galarian created.")

        if SAVE_FLUTTER:
            self.crawl_spinda_pokemon()
            print("pokemon_icons_spinda created.")
            self.crawl_regional_pokemon()
            print("pokemon_icons_regional created.")

            print("Flutter pokemon_icons updated.")

        if SAVE_FLUTTER:
            self.create_flutter_lists()
            print("Flutter lists created.")

    @staticmethod
    def check_dir_existence():
        total_pokemon_dir = [pokemon_icons_all_path,
                             pokemon_icons_blank_path,
                             pokemon_icons_shiny_path,
                             pokemon_icons_alolan_path,
                             pokemon_icons_unown_path,
                             pokemon_icons_event_path
                             ]

        for path in total_pokemon_dir:
            if not os.path.isdir(path):
                os.mkdir(path)

        if not os.path.isdir(pokemon_icons_path):
            sys.exit('Gamemaster Directory not found')

    def crawl_and_process_images(self):
        os.chdir(pokemon_icons_path)
        for file in glob.glob("*.png"):
            current_img = pokemon_icons_path + file
            self.source_img = pokemon_icons_path + file
            self.background_transparent_to_white(current_img, file)

    def autocrop_image(self, file, x, y, w, h):
        image = Image.open(self.source_img)

        if w > h:
            offset = round((w - h)/2)
            if y-offset >= 0:
                image = image.crop(box=(x, y-offset, x+w, y+h+offset))
            else:
                max_offset_y = y
                offset_y_oben = offset-y
                image = image.crop(box=(x, y-max_offset_y, x+w, y+h+offset_y_oben))
        else:
            offset = round((h - w)/2)
            if x-offset >= 0:
                image = image.crop(box=(x-offset, y, x+w+offset, y+h))
            else:
                max_offset_x = x
                offset_x_oben = offset-x
                image = image.crop(box=(x-max_offset_x, y, x+w+offset_x_oben, y+h))

        image.save(pokemon_icons_all_path + file)
        self.resize_image(pokemon_icons_all_path + file, file)

    def background_transparent_to_white(self, current_img, file):
        # source: https://twigstechtips.blogspot.com/2011/12/python-converting-transparent-areas-in.html

        image = Image.open(current_img)
        image.convert("RGBA")  # Convert this to RGBA if possible

        width = 255
        height = 255
        canvas = Image.new('RGBA', image.size, (255, 255, 255, 255))  # Empty canvas colour (r,g,b,a)
        canvas.paste(image, mask=image)  # Paste the image onto the canvas, using it's alpha channel as mask
        canvas.thumbnail([width, height], Image.ANTIALIAS)
        canvas.save(pokemon_icons_all_path + file, format="PNG")

        self.crop_and_save_image(pokemon_icons_all_path + file, file)

    def crop_and_save_image(self, current_img, file):
        # source: https://stackoverflow.com/questions/48395434/how-to-crop-or-remove-white-background-from-an-image?rq=1

        img = cv2.imread(current_img)

        # (1) Convert to gray, and threshold
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

        th, threshed = cv2.threshold(gray, 240, 255, cv2.THRESH_BINARY_INV)

        # (2) Morph-op to remove noise
        kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (11, 11))
        morphed = cv2.morphologyEx(threshed, cv2.MORPH_CLOSE, kernel)

        # (3) Find the max-area contour
        cnts = cv2.findContours(morphed, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]
        cnt = sorted(cnts, key=cv2.contourArea)[-1]

        # (4) Crop and save it
        x, y, w, h = cv2.boundingRect(cnt)

        self.autocrop_image(file, x, y, w, h)

    @staticmethod
    def resize_image(current_img, file):
        img = Image.open(current_img)
        img = img.resize((IMG_SIZE, IMG_SIZE), Image.ANTIALIAS)

        img.save(pokemon_icons_all_path + file)

    @staticmethod
    def crawl_blank_pokemon():
        os.chdir(pokemon_icons_all_path)
        for file in glob.glob("*.png"):
            if file.split('_')[-1] == '00.png' or file.split('_')[-1] == '11.png':
                name = file.split('_')[-2]
                if int(name) <= recent_gen:
                    if len(name) > 2:
                        img = Image.open(pokemon_icons_all_path + file)
                        img.save(pokemon_icons_blank_path + name + '.png')
                        if SAVE_FLUTTER:
                            img.save(flutter_path_blank + name + '.png')

    @staticmethod
    def crawl_shiny_pokemon():
        os.chdir(pokemon_icons_all_path)
        for file in glob.glob("*.png"):
            if file.split('_')[-1] == 'shiny.png' and file.split('_')[-2] == '00' or file.split('_')[-2] == '11':
                name = file.split('_')[-3]
                if int(name) <= recent_gen:
                    if len(name) > 2:
                        img = Image.open(pokemon_icons_all_path + file)
                        img.save(pokemon_icons_shiny_path + name + '.png')
                        if SAVE_FLUTTER:
                            img.save(flutter_path_shiny + name + '.png')

    @staticmethod
    def crawl_alolan_pokemon():
        os.chdir(pokemon_icons_all_path)
        for file in glob.glob("*.png"):
            if file.split('_')[-1] == '61.png' or file.split('_')[-2] == '61' and file.split('_')[-1] == 'shiny.png':
                name = file.split('_')[2]
                if int(name) <= recent_gen:
                    if 'shiny' in file:
                        name = name + '_alolan_shiny'
                    else:
                        name = name + '_alolan'

                    img = Image.open(pokemon_icons_all_path + file)
                    img.save(pokemon_icons_alolan_path + name + '.png')

                    if SAVE_FLUTTER:
                        img.save(flutter_path_alolan + name + '.png')

    @staticmethod
    def crawl_unown_pokemon():
        counter_normal = 0
        counter_shiny = 0
        os.chdir(pokemon_icons_all_path)
        for file in glob.glob("*.png"):
            if file.split('_')[2] == '201' and file.split('_')[3] != '00' and file.split('_')[-1] != '00.png':
                name = file.split('_')[2] + '_' + file.split('_')[3].split('.')[0]
                if 'shiny' not in file:
                    name = file.split('_')[2] + '_' + file.split('_')[3].split('.')[0]
                    img = Image.open(pokemon_icons_all_path + file)
                    img.save(pokemon_icons_unown_path + name + '.png')
                    if SAVE_FLUTTER:
                        img.save(flutter_path_unown + name + '.png')
                    counter_normal += 1
                else:
                    img = Image.open(pokemon_icons_all_path + file)
                    img.save(pokemon_icons_unown_path + name + '_shiny.png')
                    if SAVE_FLUTTER:
                        img.save(flutter_path_unown + name + '_shiny.png')
                    counter_shiny += 1

    @staticmethod
    def crawl_event_pokemon():
        os.chdir(pokemon_icons_all_path)
        for file in glob.glob("*.png"):
            if (len(file.split('_')) >= 6 and file.split('_')[3] != '61') or \
                (len(file.split('_')) == 5 and file.split('_')[-1] != '00.png'
                 and 'shiny' not in file and file.split('_')[3] != '61'):

                if(file.split('_')[3] != '01'):
                    nr_0 = file.split('_')[2]
                    nr_1 = file.split('_')[3]
                    if nr_1 == '':
                        nr_1 = '0'
                    nr_2 = file.split('_')[4].split('.')[0]

                    img = Image.open(pokemon_icons_all_path + file)

                    if 'shiny' not in file:
                        name = nr_0 + '_' + nr_1 + '_' + nr_2 + '_event'
                        img.save(pokemon_icons_event_path + name + '.png')
                        if SAVE_FLUTTER:
                            img.save(flutter_path_event + name + '.png')

                    else:
                        name = nr_0 + '_' + nr_1 + '_' + nr_2 + '_event_shiny'
                        img.save(pokemon_icons_event_path + name + '.png')
                        if SAVE_FLUTTER:
                            img.save(flutter_path_event + name + '.png')

    @staticmethod
    def crawl_galarian_pokemon():
        os.chdir(pokemon_icons_all_path)
        for file in glob.glob("*.png"):
            if len(file.split('_')) == 4 and file.split('_')[-1] == '31.png' or len(file.split('_')) >= 4 and file.split('_')[-2] == '31':
                # filter unown
                if 'pokemon_icon_201' in file:
                    continue

                nr = file.split('_')[2]

                img = Image.open(pokemon_icons_all_path + file)

                if 'shiny' not in file:
                    name = nr + '_galarian'
                    img.save(pokemon_icons_galarian_path + name + '.png')
                    if SAVE_FLUTTER:
                        img.save(flutter_path_galarian + name + '.png')

                else:
                    name = nr + '_galarian_shiny'
                    img.save(pokemon_icons_galarian_path + name + '.png')
                    if SAVE_FLUTTER:
                        img.save(flutter_path_galarian + name + '.png')

    @staticmethod
    def crawl_spinda_pokemon():
        os.chdir(pokemon_icons_all_path)
        for file in glob.glob("*.png"):
            if file.split('_')[2] == '327' and '00' not in file.split('_')[3]:
                nr = file.split('_')[3].split('.')[0]
                if 'shiny' not in file:
                    name = file.split('_')[2] + '_' + nr
                else:
                    name = file.split('_')[2] + '_' + nr + '_shiny'

                img = Image.open(pokemon_icons_all_path + file)
                img.save(flutter_path_spinda + name + '.png')

    @staticmethod
    def crawl_regional_pokemon():
        os.chdir(pokemon_icons_all_path)
        for file in glob.glob("*.png"):
            if '000' not in file.split('_')[2]:
                try:
                    nr = file.split('_')[2]
                    if int(nr) in regional_list:
                        if '00' in file.split('_')[3]:
                            if nr == '422':
                                if 'shiny' not in file:
                                    name = file.split('_')[2] + '_11'
                                else:
                                    name = file.split('_')[2] + '_11' + '_shiny'
                                img = Image.open(pokemon_icons_all_path + file)
                                img.save(flutter_path_regional + name + '.png')

                            else:
                                if 'shiny' not in file:
                                    name = file.split('_')[2]
                                else:
                                    name = file.split('_')[2] + '_shiny'
                                img = Image.open(pokemon_icons_all_path + file)
                                img.save(flutter_path_regional + name + '.png')

                        if '11' in file.split('_')[3] and nr == '550':
                            if 'shiny' not in file:
                                name = file.split('_')[2] + '_11'
                            else:
                                name = file.split('_')[2] + '_11' + '_shiny'
                            img = Image.open(pokemon_icons_all_path + file)
                            img.save(flutter_path_regional + name + '.png')

                        if '12' in file.split('_')[3]:
                            if 'shiny' not in file:
                                name = file.split('_')[2] + '_12'
                            else:
                                name = file.split('_')[2] + '_12' + '_shiny'
                            img = Image.open(pokemon_icons_all_path + file)
                            img.save(flutter_path_regional + name + '.png')

                except Exception as exc:
                    pass

    @staticmethod
    def create_flutter_lists():
        total_flutter_dir = [flutter_path_alolan,
                             flutter_path_blank,
                             flutter_path_event,
                             flutter_path_regional,
                             flutter_path_spinda,
                             flutter_path_unown,
                             flutter_path_galarian
                             ]

        keys = []
        path_dict = {}
        for path in total_flutter_dir:
            list_type = path.split('_')[-1][:-1]
            os.chdir(path)
            for file in glob.glob("*.png"):
                keys.append(file)

            path_dict[list_type] = keys
            keys = []

        file_name = '\\individual_collections\\individual_collection.json'
        with open(flutter_path_json + file_name, 'w') as fp:
            json.dump(path_dict, fp, sort_keys=False, indent=4)
        fp.close()


class GameMasterTextCrawler:
    def __init__(self):
        self.all_pokemon = []

        self.get_all_pokemon()
        print("get_app_pokemon successful.")
        self.crawl_pokemon_names_eng()
        print("pokemon_names_eng.json created.")
        self.crawl_pokemon_names_ger()
        print("pokemon_names_ger.json created.")
        # self.crawl_pokemon_names_fra()
        # print("pokemon_names_fra.json created.")
        self.crawl_genders()
        print("genders.json created.")

    def get_all_pokemon(self):
        os.chdir(pokemon_icons_blank_path)
        for file in glob.glob("*.png"):
            pokemon_nr = file.split('.')[0]
            self.all_pokemon.append(pokemon_nr)
        # print(self.all_pokemon)

    def crawl_pokemon_names_eng(self):
        pokemon_names_dict = {}

        with open(pokemon_gamemaster_json_path, 'r') as f:
            data = json.load(f)

        current_pokemon_name = ''

        global_key = list(data.keys())[0]
        for i in range(len(data[global_key])):
            try:
                current_pokemon_name = data[global_key][i]['genderSettings']['pokemon'].title().replace('_', ' ')
            except Exception as exc:
                pass

            if 'SPAWN' in data[global_key][i]['templateId']:
                current_pokemon = data[global_key][i]['templateId'].split('_')
                current_pokemon_nr = current_pokemon[1][1:]
                current_pokemon_nr = current_pokemon_nr[1:]

                current_pokemon_kind = ''

                if current_pokemon[-1] == 'ALOLA':
                    current_pokemon_kind = current_pokemon[-1]
                    current_pokemon_name = current_pokemon_name + ' (Alolan)'

                if current_pokemon_kind == '':
                    json_new_key = current_pokemon_nr
                else:
                    json_new_key = current_pokemon_nr+'_alolan'

                    print(current_pokemon_name)

                if json_new_key not in list(pokemon_names_dict.keys()):
                    if json_new_key in self.all_pokemon or 'Alolan' in current_pokemon_name:
                        pokemon_names_dict.update({
                            json_new_key: current_pokemon_name
                        })

        file_eng = 'pokemon_en.json'
        with open(pokemon_json_pokemon_names+file_eng, 'w') as fp:
            json.dump(pokemon_names_dict, fp, sort_keys=False, indent=4)
        fp.close()

        if SAVE_FLUTTER:
            with open(flutter_path_json + file_eng, 'w') as fp:
                json.dump(pokemon_names_dict, fp, sort_keys=False, indent=4)
            fp.close()

    def crawl_pokemon_names_ger(self):
        pokemon_names_dict = {}

        file = 'merged #13.txt'
        current_file = pokemon_gamemaster_txt_pokemon_names_translation_ger_path + file
        with open(current_file, 'r', encoding='utf8') as fp:
            line = fp.readlines()

        print('pokemon_name' in line[15776])
        for i in range(len(line)):
            if "pokemon_name" in line[i]:
                key = line[i].replace('\t', '').split('"')[1].split('_')[-1][1:]
                name = line[i+1].replace('\t', '').split('"')[1]
                if 'Nidoran' in name:
                    name = name[:-1]

                pokemon_names_dict.update({
                    key: name
                })

        # print(pokemon_names_dict)

        file_eng = 'pokemon_en.json'
        with open(pokemon_json_pokemon_names+file_eng, 'r') as f:
            data = json.load(f)

        key_en_list = data.keys()
        key_de_list = pokemon_names_dict.keys()
        print(key_de_list)

        for key_de in key_de_list:
            if key_de in key_en_list:
                data[key_de] = pokemon_names_dict[key_de]

        for key_en in key_en_list:
            if 'alolan' in key_en:
                help_key_en = key_en.split('_')[0]
                data[key_en] = pokemon_names_dict[help_key_en] + ' (Alola)'

        data.pop('000', None)

        file_ger = 'pokemon_de.json'
        with open(pokemon_json_pokemon_names+file_ger, 'w') as fp:
            json.dump(data, fp, sort_keys=False, indent=4)

        fp.close()
        f.close()

        if SAVE_FLUTTER:
            with open(flutter_path_json + file_ger, 'w') as fp:
                json.dump(data, fp, sort_keys=False, indent=4)
            fp.close()

    def crawl_pokemon_names_fra(self):
        pokemon_names_dict = {}

        file = 'merged #10.txt'
        current_file = pokemon_gamemaster_txt_pokemon_names_translation_ger_path + file
        with open(current_file, 'r', encoding='utf8') as fp:
            line = fp.readlines()

        print('pokemon_name' in line[15776])
        for i in range(len(line)):
            if "pokemon_name" in line[i]:
                key = line[i].replace('\t', '').split('"')[1].split('_')[-1][1:]
                name = line[i+1].replace('\t', '').split('"')[1]
                if 'Nidoran' in name:
                    name = name[:-1]

                print(name)

                pokemon_names_dict.update({
                    key: name
                })

        # print(pokemon_names_dict)

        file_eng = 'pokemon_en.json'
        with open(pokemon_json_pokemon_names+file_eng, 'r') as f:
            data = json.load(f)

        key_en_list = data.keys()
        key_de_list = pokemon_names_dict.keys()
        print(key_de_list)

        for key_de in key_de_list:
            if key_de in key_en_list:
                data[key_de] = pokemon_names_dict[key_de]

        for key_en in key_en_list:
            if 'alolan' in key_en:
                help_key_en = key_en.split('_')[0]
                data[key_en] = pokemon_names_dict[help_key_en] + ' (Alola)'

        data.pop('000', None)

        file_fra = 'pokemon_fr.json'
        with open(pokemon_json_pokemon_names+file_fra, 'w') as fp:
            json.dump(data, fp, sort_keys=False, indent=4)

        fp.close()
        f.close()

        if SAVE_FLUTTER:
            with open(flutter_path_json + file_fra, 'w') as fp:
                json.dump(data, fp, sort_keys=False, indent=4)
            fp.close()

    def crawl_genders(self):
        gender_dict = {}
        values = []

        pokemon_nr = ''
        pokemon_list = []
        with open(pokemon_gamemaster_json_path, 'r') as f:
            data = json.load(f)

        global_key = list(data.keys())[0]
        for i in range(len(data[global_key])):
            if 'SPAWN' in data[global_key][i]['templateId']:
                current_pokemon = data[global_key][i]['templateId'].split('_')

                if 'FALL' in current_pokemon:
                    continue

                current_pokemon_nr = current_pokemon[1][1:]
                current_pokemon_nr = current_pokemon_nr[1:]
                gender = data[global_key][i]['genderSettings']['gender']

                if current_pokemon_nr in self.all_pokemon:

                    if current_pokemon_nr not in  pokemon_list:
                        pokemon_list.append(current_pokemon_nr)
                        tmp_dict = {
                            'id': int(current_pokemon_nr),
                            'gender': gender
                        }

                if tmp_dict not in values:
                    values.append(tmp_dict)

        gender_dict = values

        file_gender = 'gender.json'
        with open(pokemon_json_pokemon_names+file_gender, 'w') as fp:
            json.dump(gender_dict, fp, sort_keys=False, indent=4)
        fp.close()

        if SAVE_FLUTTER:
            with open(flutter_path_json + 'official_collections\\' + file_gender, 'w') as fp:
                json.dump(gender_dict, fp, sort_keys=False, indent=4)
            fp.close()


if __name__ == "__main__":
    # constants
    IMG_SIZE = 50 #50

    # pokemon png path
    pokemon_icons_path = "C:\\Users\\Khang Dinh\\Documents\\PogoAssets-master\\pokemon_icons\\"
    pokemon_icons_all_path = "C:\\Users\\Khang Dinh\\Documents\\pokemon_icons_all\\"
    pokemon_icons_blank_path = "C:\\Users\\Khang Dinh\\Documents\\pokemon_icons_blank\\"
    pokemon_icons_shiny_path = "C:\\Users\\Khang Dinh\\Documents\\pokemon_icons_shiny\\"
    pokemon_icons_alolan_path = "C:\\Users\\Khang Dinh\\Documents\\pokemon_icons_alolan\\"
    pokemon_icons_unown_path = "C:\\Users\\Khang Dinh\\Documents\\pokemon_icons_unown\\"
    pokemon_icons_event_path = "C:\\Users\\Khang Dinh\\Documents\\pokemon_icons_event\\"
    pokemon_icons_galarian_path = "C:\\Users\\Khang Dinh\\Documents\\pokemon_icons_galarian\\"

    # pokemon text path
    pokemon_gamemaster_json_path = "C:\\Users\\Khang Dinh\\Documents\\PogoAssets-master\\gamemaster\\gamemaster.json"
    pokemon_json_pokemon_names = "C:\\Users\\Khang Dinh\\Documents\\pokemon_json\\"
    pokemon_gamemaster_json_pokemon_path = "C:\\Users\\Khang Dinh\\Documents\\PogoAssets-master\\decrypted_assets\\txt\\pokemon.txt"
    pokemon_gamemaster_txt_pokemon_names_translation_ger_path = "C:\\Users\\Khang Dinh\\Documents\\PogoAssets-master\\static_assets\\txt\\"

    # flutter png path
    flutter_path_blank = "B:\\Github\\Tradedex\\assets_bundle\\pokemon_icons_blank\\"
    flutter_path_shiny = "B:\\Github\\Tradedex\\assets_bundle\\pokemon_icons_shiny\\"
    flutter_path_alolan = "B:\\Github\\Tradedex\\assets_bundle\\pokemon_icons_alolan\\"
    flutter_path_unown = "B:\\Github\\Tradedex\\assets_bundle\\pokemon_icons_unown\\"
    flutter_path_event = "B:\\Github\\Tradedex\\assets_bundle\\pokemon_icons_event\\"
    flutter_path_spinda = 'B:\\Github\\Tradedex\\assets_bundle\\pokemon_icons_spinda\\'
    flutter_path_regional = 'B:\\Github\\Tradedex\\assets_bundle\\pokemon_icons_regional\\'
    flutter_path_galarian = 'B:\\Github\\Tradedex\\assets_bundle\\pokemon_icons_galarian\\'

    # flutter text path
    flutter_path_json = 'B:\\Github\\Tradedex\\json\\'

    # save in Flutter directory
    SAVE_FLUTTER = False

    # set highest pokemon number
    recent_gen = 850

    # set regional list
    regional_list = [
        83, 115, 122, 128, 214, 222, 324, 335, 336, 337, 338, 369, 314, 313, 357, 417, 422, 441, 455, 480, 481, 482,
        511, 513, 515, 538, 539, 550, 556, 561, 626, 631, 632
    ]

    # run Crawler
    GamemasterImageCrawler()
    GameMasterTextCrawler()
