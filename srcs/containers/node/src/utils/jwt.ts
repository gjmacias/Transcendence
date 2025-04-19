import jwt from "jsonwebtoken";
import type { JwtPayload } from "jsonwebtoken"; // ✅ ESTA LÍNEA ES CLAVE

const JWT_SECRET = process.env.JWT_SECRET || "dev-mode-key";

export function generateToken(payload: object): string {
  return jwt.sign(payload, JWT_SECRET, { expiresIn: "6h" });
}

export function verifyToken(token: string): JwtPayload | null {
    try {
      const decoded = jwt.verify(token, JWT_SECRET);
      if (typeof decoded === "string") return null;
      return decoded;
    } catch (err) {
      return null;
    }
}
