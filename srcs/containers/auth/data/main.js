import express from 'express';
import dotenv from 'dotenv';
import authController from './authController.js';

dotenv.config();

const app = express();
const PORT = 3000;

app.get('/auth/42', authController.login);
app.get('/auth/42/callback', authController.callback);

app.listen(PORT, () => {
	console.log(`Auth service running on http://localhost:${PORT}`);
});