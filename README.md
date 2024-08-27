# Undergrad_Thesis

## Title
Using Artificial Intelligence to Risk Stratify ECGs at Triage for Patients Presenting to Emergency Departments with Chest Pain


#### Supervisors: Ervin Sejdic and Rohit Mohindra


### Abstract
This thesis develops a Machine Learning-based tool for Electrocardiogram (ECG) analysis, designed to enhance the diagnosis of Occlusion Myocardial Infarction (OMI) in emergency departments. Amidst the high-stakes and fast-paced environment of emergency care, the swift and accurate identification of OMI can be lifesaving. The proposed tool leverages a Random Forest classifier, optimized to interpret ECG features for OMI detection. The thesis focuses on examining relevant literature and outlines the feature engineering process in detail, ensuring data integrity and selecting pertinent features.

The proposed design utilizes BREAVEHEART for feature computation and Python for risk analysis. The design is deliberately engineered to bridge different computational platforms, creating a streamlined process. A comprehensive dataset, provided by PhysioNet, is utilized to test the ability of the classifier.

The findings indicate that Machine Learning can aid clinical decision-making by providing rapid risk stratification for patients with suspected OMI. However, given the complexity of ECGs and the frequent data skew, traditional diagnostic approaches might lead to misdiagnosis. This thesis lays the groundwork for future enhancements, including refining the user interface for clinical application and expanding the dataset to include a wider array of ECG presentations. These enhancements ensure the tool’s adaptability and effectiveness across various clinical scenarios. The ultimate aim of this thesis is to support an AI-assisted approach in emergency settings, potentially reducing the morbidity and mortality associated with OMI.

### Overview of this Repository
This repository only contains the code for thesis. ```BREAVEHEART-main``` is forked from [BREAVEHEART](https://github.com/BIVectors/BRAVEHEART) with some additional files to compute specific features that the original code did not handle. The ReadMe file in ```BREAVEHEART-main``` is the same as [BREAVEHEART](https://github.com/BIVectors/BRAVEHEART).
