import subprocess as sb

if __name__ == "__main__":

    print("Testing listen.py")
    listen_cmd = "pytest /app/test/test_listen.py"
    sb.call([listen_cmd], shell=True)