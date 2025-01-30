# Step 1: Use a base image
FROM node:14

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy the application code into the container
COPY . .

# Step 4: Install dependencies
RUN npm install

# Step 5: Expose the port the app will run on
EXPOSE 3000

# Step 6: Command to run the application
CMD ["npm", "start"]
