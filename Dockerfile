# Step 1: Use an official Node.js image as the base image
FROM node:16

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Step 4: Copy the application code into the container
COPY . .

# Step 5: Expose the application port
EXPOSE 3000

# Step 6: Define the command to run the app
CMD ["npm", "start"]
