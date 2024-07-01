from flask import Flask, request
import numpy as np
import pickle
import os

app = Flask(__name__)

cur_dir = os.path.dirname(__file__)
clf = pickle.load(open(os.path.join(cur_dir, 'pkl_objects', 'lr.pkl'), 'rb'))
sc = pickle.load(open(os.path.join(cur_dir, 'pkl_objects', 'standardscaler.pkl'), 'rb'))

@app.route('/api', methods = ['GET'])
def getproba():
    d = {}
    params = ['Age', 'RestingBP', 'Cholesterol', 'MaxHR', 'FastingBS', 'Oldpeak', 'Sex',
              'ChestPainType', 'RestingECG', 'ExerciseAngina', 'ST_Slope']
    
    data = np.empty((1, len(params)))

    for i in range(len(params)):
        data[0][i] = float(str(request.args[params[i]]))

    data[:, 0:4] = sc.transform(data[:, 0:4])

    pred = clf.predict_proba(data)[0][1]
    d['output'] = pred
    
    return d

if __name__ == '__main__':
    app.run()