from flask import Flask, request, jsonify
import numpy as np 
import string
from nltk.corpus import stopwords
import pandas as pd 
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.tree import DecisionTreeClassifier
from sklearn.feature_extraction.text import TfidfTransformer,TfidfVectorizer
from sklearn.pipeline import Pipeline
app=Flask(__name__)
@app.route('/api', methods=['GET'])
def help():
    d={}
    inputchr=str(request.args['query'])
    arr=[[inputchr]]
    df=pd.read_csv("dialogs.csv",sep="\t")
    questions=df.iloc[:,0:1].values
    answers=df.iloc[:,1:2].values
    questions=np.append(questions,[['Hi'],['Hello'],['how are you'],['how are you doing']])
    answers=np.append(answers,[['hello'],['hi'],["i'm fine. how about yourself?"],["i'm fine. how about yourself?"]])
    def cleaner(x):
        return [a for a in (''.join([a for a in x if a not in string.punctuation])).lower().split()]
    Pipe = Pipeline([
        ('bow',CountVectorizer(analyzer=cleaner)),
        ('tfidf',TfidfTransformer()),
        ('classifier',DecisionTreeClassifier())
    ])
    Pipe.fit(questions,answers)
    answer=Pipe.predict(arr)[0]
    
    #answer.append(str)
    d['output']=answer
    return d
if(__name__ == '__main__'):
    app.run()