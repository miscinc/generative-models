# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the requirements file into the container
COPY requirements/pt2.txt ./
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r pt2.txt

# Install the application
RUN pip install .

# Make port available to the world outside this container
EXPOSE 8501

# Define environment variable
ENV NAME generative-models

# Install additional dependencies for `sgm` and `sdata`
RUN pip install -e git+https://github.com/Stability-AI/datapipelines.git@main#egg=sdata

# Run streamlit app when the container launches
CMD ["streamlit", "run", "scripts/demo/sampling.py", "--server.port", "8501"]