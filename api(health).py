import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from flask import Flask, request, jsonify
train=pd.read_csv("Training.csv")
X = train.iloc[:, 0:132].values
y = train.iloc[:, -1].values

from sklearn.preprocessing import LabelEncoder
labelencoder = LabelEncoder()
y = labelencoder.fit_transform(y)

dimensionality_reduction = train.groupby(train['prognosis']).max()
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)
from sklearn.tree import DecisionTreeClassifier
classifier = DecisionTreeClassifier()
classifier.fit(X_train, y_train)
cols=train.columns
cols=cols[:-1]
features = cols.values
app=Flask(__name__)
@app.route('/api', methods=['GET'])
def help():
    d=[]
    symptoms=[]
    string=str(request.args['query'])
    arr=string.split(',')
    for _ in features:
        if _ in arr:
            symptoms.append(1)
        else:
            symptoms.append(0)
    val=classifier.predict([symptoms])
    print(labelencoder.inverse_transform([val[0]]))
    disease=labelencoder.inverse_transform([val[0]])[0]
    d.append(disease)
    return d
if(__name__ == '__main__'):
    app.run()