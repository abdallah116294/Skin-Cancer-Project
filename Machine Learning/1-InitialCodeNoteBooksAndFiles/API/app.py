from fastapi import FastAPI, File, UploadFile
from PIL import Image
import io
import numpy as np
import tensorflow as tf
import cv2
import numpy as np

app = FastAPI()

classes_model_1 = ['Not Skin', 'Skin']
classes_model_2_3 = ['Melanoma', 'Melanocytic Nevi', 'Basal Cell Carcinoma', 'Actinic Keratosis', 'Benign Keratosis-Like Lesion', 'Dermatofibroma', 'Vascular Lesion', 'Squamous cell carcinoma', 'Seborrheic keratoses']

def run_model(model_id, input_data):
    input_data = process_image(input_data, model_id)

    model_1_interpreter = tf.lite.Interpreter(model_path='models/SkinOrNotModel.tflite')
    model_1_interpreter.allocate_tensors()

    model_2_interpreter = tf.lite.Interpreter(model_path='models/Dermascope_image_model.tflite')
    model_2_interpreter.allocate_tensors()

    model_3_interpreter = tf.lite.Interpreter(model_path='models/Clinical_image_model.tflite')
    model_3_interpreter.allocate_tensors()

    model_4_interpreter = tf.lite.Interpreter(model_path='models/Disease_or_not.tflite')
    model_4_interpreter.allocate_tensors()



    model_1_input_details = model_1_interpreter.get_input_details()
    model_1_output_details = model_1_interpreter.get_output_details()

    model_2_input_details = model_2_interpreter.get_input_details()
    model_2_output_details = model_2_interpreter.get_output_details()

    model_3_input_details = model_3_interpreter.get_input_details()
    model_3_output_details = model_3_interpreter.get_output_details()

    model_4_input_details = model_4_interpreter.get_input_details()
    model_4_output_details = model_4_interpreter.get_output_details()

    output_data = []

    if model_id == 1:
        model_1_interpreter.set_tensor(model_1_input_details[0]['index'], input_data)
        model_1_interpreter.invoke()
        output_data.append(model_1_interpreter.get_tensor(model_1_output_details[0]['index']))
    elif model_id == 2:
        model_2_interpreter.set_tensor(model_2_input_details[0]['index'], input_data)
        model_2_interpreter.invoke()
        output_data.append(model_2_interpreter.get_tensor(model_2_output_details[0]['index']))

        model_3_interpreter.set_tensor(model_3_input_details[0]['index'], input_data)
        model_3_interpreter.invoke()
        output_data.append(model_3_interpreter.get_tensor(model_3_output_details[0]['index']))

    elif model_id == 3:
        model_4_interpreter.set_tensor(model_4_input_details[0]['index'], input_data)
        model_4_interpreter.invoke()
        output_data.append(model_4_interpreter.get_tensor(model_4_output_details[0]['index']))

    return output_data

def process_image(image, model_id):
    img = Image.open(io.BytesIO(image)).convert("RGB")
    img = img.resize((128,128))
    if model_id == 3 or model_id == 1:
        crop_percentage = 0.5
        width, height = img.size
        left = width * (1 - crop_percentage) / 2
        upper = height * (1 - crop_percentage) / 2
        right = width * (1 + crop_percentage) / 2
        lower = height * (1 + crop_percentage) / 2
        crop_box = (left, upper, right, lower)
        img = img.crop(crop_box)
    img = img.resize((128,128))
    img_array = np.asarray(img, dtype = np.float32)
    img_array = np.expand_dims(img_array, axis=0)
    return img_array

@app.post("/predict/{model_id}")
async def predict(model_id: int, image: UploadFile = File(...)):
    img = await image.read()
    prediction = run_model(model_id, img)

    if model_id == 1:
        classes = classes_model_1
        predicted_class = classes[int( tf.math.sigmoid(prediction[0]) > .5 )]
    elif model_id == 2:
        disease_or_not = run_model(3, img)[0]
        disease_or_not = tf.nn.softmax(disease_or_not[0])
        print(disease_or_not)
        disease_or_not = np.argmax(disease_or_not)

        if disease_or_not == 1:
            classes = classes_model_2_3
            prediction_model_2 = tf.nn.softmax(prediction[0])
            prediction_model_3 = tf.nn.softmax(prediction[1])

            #final_predictions_part1 = tf.maximum(prediction_model_2[0,:4], prediction_model_3[0,:4])
            final_predictions_part1 = prediction_model_2[0,:4]
            final_predictions_part_2 = tf.concat([prediction_model_2[0,-3:], prediction_model_3[0,-2:]], axis=0)
            final_predictions = tf.concat([final_predictions_part1, final_predictions_part_2], axis=0)

            print(prediction_model_2)
            print(prediction_model_3)
            print(final_predictions_part1)
            print(final_predictions)

            if np.max(final_predictions) > .3:
                predicted_class_index = np.argmax(final_predictions)
                predicted_class = classes[predicted_class_index]
            else:
                predicted_class = "Couldn't identify lesion"
        else:
            predicted_class = "Couldn't identify lesion"
    else:
        return {"error": "Invalid model ID"}
    
    return {"prediction": predicted_class}
