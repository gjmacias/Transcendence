import { Request, Response, NextFunction } from "express";
import { verifyToken } from "../utils/jwt";

export function requireAuth(req: Request, res: Response, next: NextFunction) {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ error: "Token requerido" });

  const token = authHeader.split(" ")[1]; // formato: "Bearer <token>"
  const decoded = verifyToken(token);
  if (!decoded) return res.status(403).json({ error: "Token inválido" });

  // Lo adjuntamos al request
  (req as any).user = decoded;
  next();
}
