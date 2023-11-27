import streamlit as st
import pandas as pd
from joblib import load

# Load the trained model
model = load('decision_tree_model.joblib')

# Function to get user input
def user_input_features():
    st.sidebar.header('Machine Features')
    # Here you will add user inputs for each feature
    type_map = {'Low': 0, 'Medium': 1, 'High': 2}
    type = st.sidebar.selectbox('Type', ('Low', 'Medium', 'High'))
    air_temperature_k = st.sidebar.number_input('Air temperature [K]', value=298.1)
    process_temperature_k = st.sidebar.number_input('Process temperature [K]', value=308.6)
    rotational_speed_rpm = st.sidebar.number_input('Rotational speed [rpm]', value=1551)
    torque_nm = st.sidebar.number_input('Torque [Nm]', value=42.8)
    tool_wear_min = st.sidebar.number_input('Tool wear [min]', value=0)

    # Store the inputs in a dictionary
    data = {
        'Type': type_map[type],
        'Air temperature [K]': air_temperature_k,
        'Process temperature [K]': process_temperature_k,
        'Rotational speed [rpm]': rotational_speed_rpm,
        'Torque [Nm]': torque_nm,
        'Tool wear [min]': tool_wear_min
    }
    
    # Convert the dictionary to a pandas DataFrame
    features = pd.DataFrame(data, index=[0])
    return features

# Main app
def main():
    st.title('Machine Failure Prediction App')

    # Get user input
    input_df = user_input_features()

    # Display the user input features
    st.subheader('User Input features')
    st.write(input_df)

    # Prediction
    prediction = model.predict(input_df)
    prediction_proba = model.predict_proba(input_df)

    st.subheader('Prediction')
    failure_mapping = {0: 'No Failure', 1: 'Failure'}
    st.write(failure_mapping[prediction[0]])

    st.subheader('Prediction Probability')
    st.write(prediction_proba)

if __name__ == '__main__':
    main()
