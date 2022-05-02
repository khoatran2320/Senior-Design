from file_utils import read_txt_file

def get_box_user_id():
	boxiId = read_txt_file('../connect/box_id.txt')
	userId = read_txt_file('../connect/user_id.txt')
	return dict({'boxiId':boxiId[0], 'userId':userId[0]})
