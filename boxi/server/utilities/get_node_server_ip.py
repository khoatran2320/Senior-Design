from .file_utils import read_txt_file

def get_node_server_ip():
    ip = read_txt_file('/home/pi/Desktop/Senior-Design/boxi/server/utilities/node_server_ip.txt')[0]
    return ip

if __name__ == "__main__":
    print(get_node_server_ip())
