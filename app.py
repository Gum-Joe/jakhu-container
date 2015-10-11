import sys
sys.path.insert(0, 'python')
import methods

if str(sys.argv[1]) == 'POST' or 'post':
    methods.post(str(sys.argv[3]), str(sys.argv[2]))
    pass
