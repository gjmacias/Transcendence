import express from "express";
import dotenv from "dotenv";
import authRoutes from "./routes/auth";
import profileRoutes from "./routes/profile";

dotenv.config();
const app = express();

app.use(express.json());
app.use(authRoutes);    // Rutas públicas (ej: /auth/google)
app.use(profileRoutes);   // Rutas protegidas


const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`🚀 Node middleware corriendo en puerto ${PORT}`);
});
