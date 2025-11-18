import { useState } from 'react';
import { Button } from './ui/button';
import { Input } from './ui/input';
import { Label } from './ui/label';
import { Switch } from './ui/switch';
import { Flower2 } from 'lucide-react';

interface LoginScreenProps {
  onLogin: (email: string) => void;
  onSignUpClick?: () => void;
}

export function LoginScreen({ onLogin, onSignUpClick }: LoginScreenProps) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [rememberMe, setRememberMe] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!email || !password) {
      setError('Por favor completa todos los campos');
      return;
    }

    if (!email.includes('@')) {
      setError('Por favor ingresa un correo electrónico válido');
      return;
    }

    // Simulación de validación
    onLogin(email);
  };

  return (
    <div className="min-h-screen flex flex-col items-center justify-center p-6 relative overflow-hidden">
      {/* Fondo con gradiente morado vibrante y efecto bokeh */}
      <div 
        className="absolute inset-0 z-0"
        style={{
          background: 'linear-gradient(135deg, #E879F9 0%, #C084FC 20%, #A855F7 50%, #9333EA 75%, #7C3AED 100%)',
        }}
      >
        {/* Círculos borrosos para efecto bokeh */}
        <div className="absolute top-20 left-10 w-40 h-40 rounded-full bg-white/30 blur-3xl"></div>
        <div className="absolute top-40 right-20 w-60 h-60 rounded-full bg-[#FFB3D9]/40 blur-3xl"></div>
        <div className="absolute bottom-32 left-20 w-48 h-48 rounded-full bg-white/25 blur-3xl"></div>
        <div className="absolute bottom-20 right-16 w-56 h-56 rounded-full bg-[#E879F9]/30 blur-3xl"></div>
        <div className="absolute top-1/2 left-1/3 w-32 h-32 rounded-full bg-white/20 blur-2xl"></div>
      </div>

      {/* Tarjeta blanca central */}
      <div className="w-full max-w-md bg-white rounded-3xl shadow-2xl p-8 relative z-10">
        {/* Logo y título */}
        <div className="flex flex-col items-center space-y-4 mb-8">
          <div className="bg-[#7C3AED] rounded-3xl p-5 relative overflow-hidden">
            <Flower2 className="w-12 h-12 text-white relative z-10" />
            {/* Sparkles/brillitos blancos */}
            <div className="absolute top-2 left-2 w-2 h-2 bg-white rounded-full opacity-90 animate-pulse" style={{ animationDelay: '0s' }}></div>
            <div className="absolute top-3 right-3 w-1.5 h-1.5 bg-white rounded-full opacity-80 animate-pulse" style={{ animationDelay: '0.3s' }}></div>
            <div className="absolute bottom-3 left-4 w-1 h-1 bg-white rounded-full opacity-70 animate-pulse" style={{ animationDelay: '0.6s' }}></div>
            <div className="absolute bottom-4 right-2 w-1 h-1 bg-white rounded-full opacity-85 animate-pulse" style={{ animationDelay: '0.9s' }}></div>
          </div>
          <h1 className="text-[#7C3AED]">Azzuna</h1>
          <p className="text-gray-700">
            Haz sonreir con flores
          </p>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-5">
          <div className="space-y-4">
            {/* Email */}
            <div className="space-y-2">
              <Label htmlFor="email" className="text-gray-800">Correo electrónico</Label>
              <Input
                id="email"
                type="email"
                placeholder="tu@email.com"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="bg-gray-50 border-0 rounded-xl py-6"
              />
            </div>

            {/* Password */}
            <div className="space-y-2">
              <Label htmlFor="password" className="text-gray-800">Contraseña</Label>
              <Input
                id="password"
                type="password"
                placeholder="•••••••"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="bg-gray-50 border-0 rounded-xl py-6"
              />
            </div>

            {/* Remember me */}
            <div className="flex items-center space-x-3 pt-2">
              <Switch
                id="remember"
                checked={rememberMe}
                onCheckedChange={setRememberMe}
                className="data-[state=checked]:bg-[#E879F9]"
              />
              <Label htmlFor="remember" className="cursor-pointer text-gray-800">
                Recordarme
              </Label>
            </div>
          </div>

          {/* Error message */}
          {error && (
            <div className="bg-red-50 text-red-600 p-3 rounded-xl">
              {error}
            </div>
          )}

          {/* Submit button */}
          <Button 
            type="submit" 
            className="w-full bg-[#7C3AED] hover:bg-[#6D28D9] text-white py-6 rounded-xl"
          >
            Iniciar sesión
          </Button>

          {/* Forgot password */}
          <div className="text-center pt-2">
            <button
              type="button"
              className="text-[#7C3AED] underline underline-offset-4"
              onClick={() => alert('Funcionalidad de recuperación de contraseña')}
            >
              ¿Olvidaste tu contraseña?
            </button>
          </div>

          {/* Sign up link */}
          <div className="text-center pt-4 border-t border-gray-200">
            <p className="text-gray-600 mb-3">¿No tienes una cuenta?</p>
            <Button 
              type="button"
              variant="outline"
              className="w-full border-2 border-[#7C3AED] text-[#7C3AED] hover:bg-[#7C3AED]/10 py-6 rounded-xl"
              onClick={onSignUpClick}
            >
              Crear cuenta
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
}