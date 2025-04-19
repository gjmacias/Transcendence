import express from "express";
import { requireAuth } from "../middleware/auth";

const router = express.Router();

// Ruta protegida con middleware
router.get("/perfil", requireAuth, (req, res) => {
  const user = (req as any).user;
  res.json({
    message: `Hola ${user.name}, tu sesión es válida.`,
    datos: user
  });
});

export default router;
