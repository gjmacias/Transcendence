import express from "express";
import { verifyGoogleToken } from "../services/google";
import { generateToken } from "../utils/jwt";

const router = express.Router();

router.post("/auth/google", async (req, res) => {
  const { token } = req.body;

  if (!token) {
    return res.status(400).json({ error: "Token no enviado" });
  }

  const userData = await verifyGoogleToken(token);
  if (!userData) {
    return res.status(401).json({ error: "Token inválido" });
  }


// Creamos nuestro JWT personalizado
    const ourToken = generateToken({
        userId: userData.sub,
        email: userData.email,
        name: userData.name,
  });
  
  return res.status(200).json({
    message: "Autenticado con Google",
    token: ourToken,
    user: userData,
  });
});

export default router;
