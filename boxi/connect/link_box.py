import requests

def link_box():
	userId = None
	boxId = None
	with open("user_id.txt") as f:
		lines = [line.rstrip('\n') for line in f]
		userId = lines[0]
	with open("box_id.txt") as f:
		lines = [line.rstrip('\n') for line in f]
		boxId = lines[0]
	reqBody = dict({"userId" : userId, "boxiId": boxId})
	r = requests.post("ec2-54-227-230-171.compute-1.amazonaws.com:3000/boxi/add-box", json=reqBody, verify=False)
	print(r.text)
if __name__ == "__main__":
	link_box()
