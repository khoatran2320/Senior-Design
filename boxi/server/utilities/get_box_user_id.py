from .file_utils import read_txt_file

def get_box_user_id():
	boxiId = read_txt_file('/home/pi/Desktop/Senior-Design/boxi/connect/box_id.txt')
	userId = read_txt_file('/home/pi/Desktop/Senior-Design/boxi/connect/user_id.txt')
	return dict({'boxiId':boxiId[0], 'userId':userId[0]})
