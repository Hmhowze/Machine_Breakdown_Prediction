# Machine_Breakdown_Prediction

# About Dataset
Machine Predictive Maintenance Classification Dataset
Since real predictive maintenance datasets are generally difficult to obtain and in particular difficult to publish, we present and provide a synthetic dataset that reflects real predictive maintenance encountered in the industry to the best of our knowledge.

The dataset consists of 10 000 data points stored as rows with 14 features in columns

UID: unique identifier ranging from 1 to 10000

productID: consisting of a letter L, M, or H for low (50% of all products), medium (30%), and high (20%) as product quality variants and a variant-specific serial number

air temperature [K]: generated using a random walk process later normalized to a standard deviation of 2 K around 300 K

process temperature [K]: generated using a random walk process normalized to a standard deviation of 1 K, added to the air temperature plus 10 K.

rotational speed [rpm]: calculated from powepower of 2860 W, overlaid with a normally distributed noise

torque [Nm]: torque values are normally distributed around 40 Nm with an Ïƒ = 10 Nm and no negative values.

tool wear [min]: The quality variants H/M/L add 5/3/2 minutes of tool wear to the used tool in the process. and a
'machine failure' label that indicates, whether the machine has failed in this particular data point for any of the following failure modes are true.

\\\ METHOD/TOOL FOR HIGHLIGHTING FAILURES WHEN PLOTTING TWO VARIABLES \\\
- Use the package ''gghighlight'
>install.packages("gghighlight")
>library(ggplot2)
>library(gghighlight)
- Use this in combination with a ggplot:
>ggplot(updated, mapping=aes(Air.temperature..K.,Process.temperature..K.)) + geom_point(col='black') + gghighlight(Target==1,unhighlighted_colour = alpha("steelblue", 0.4))
- The code will set non-failures to "steelblue", and failures to black.

\\ METHODS/TOOLS: SPLITTING THE DATASET BASED ON MACHINE TYPE \\
- Split the dataset into a Large List with 3 objects based on type
>master_split <- split(<updated_master>, <updated_master>$Type)
- Split master_split into three separate dataframes based on type for future exploration
>master_H <- data.frame(master_split['H'])
>>master_L <- data.frame(master_split['L'])
>>>master_M <- data.frame(master_split['M'])
