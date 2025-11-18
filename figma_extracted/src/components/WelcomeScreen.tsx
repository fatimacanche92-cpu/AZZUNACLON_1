import { useEffect } from 'react';
import { Flower2, Sparkles } from 'lucide-react';

interface WelcomeScreenProps {
  email: string;
  onComplete: () => void;
}

export function WelcomeScreen({ email, onComplete }: WelcomeScreenProps) {
  useEffect(() => {
    const timer = setTimeout(() => {
      onComplete();
    }, 2000);

    return () => clearTimeout(timer);
  }, [onComplete]);

  return (
    <div className="min-h-screen bg-background flex flex-col items-center justify-center p-6">
      <div className="w-full max-w-sm space-y-6 text-center">
        <div className="flex justify-center">
          <div className="relative">
            <div className="bg-primary rounded-2xl p-4 relative overflow-hidden">
              <Flower2 className="w-16 h-16 text-primary-foreground relative z-10" />
              {/* Sparkles/brillitos blancos */}
              <div className="absolute top-3 left-3 w-2.5 h-2.5 bg-white rounded-full opacity-90 animate-pulse" style={{ animationDelay: '0s' }}></div>
              <div className="absolute top-4 right-4 w-2 h-2 bg-white rounded-full opacity-80 animate-pulse" style={{ animationDelay: '0.3s' }}></div>
              <div className="absolute bottom-4 left-5 w-1.5 h-1.5 bg-white rounded-full opacity-70 animate-pulse" style={{ animationDelay: '0.6s' }}></div>
              <div className="absolute bottom-5 right-3 w-1.5 h-1.5 bg-white rounded-full opacity-85 animate-pulse" style={{ animationDelay: '0.9s' }}></div>
            </div>
            <div className="absolute -top-2 -right-2 animate-bounce">
              <Sparkles className="w-8 h-8 text-secondary" />
            </div>
          </div>
        </div>
        
        <div className="space-y-2">
          <h2>¡Bienvenido de nuevo!</h2>
          <p className="text-muted-foreground">
            {email}
          </p>
        </div>

        <div className="flex justify-center gap-2">
          <div className="w-2 h-2 bg-primary rounded-full animate-pulse" style={{ animationDelay: '0ms' }} />
          <div className="w-2 h-2 bg-primary rounded-full animate-pulse" style={{ animationDelay: '150ms' }} />
          <div className="w-2 h-2 bg-primary rounded-full animate-pulse" style={{ animationDelay: '300ms' }} />
        </div>
      </div>
    </div>
  );
}
