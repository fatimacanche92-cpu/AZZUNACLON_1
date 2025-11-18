import { Label } from './ui/label';
import { Switch } from './ui/switch';
import { Card } from './ui/card';
import { Separator } from './ui/separator';
import { Moon, Sun, Palette, User, Bell, Shield, HelpCircle, LogOut } from 'lucide-react';

interface SettingsViewProps {
  darkMode: boolean;
  onToggleDarkMode: () => void;
}

export function SettingsView({ darkMode, onToggleDarkMode }: SettingsViewProps) {
  return (
    <div className="space-y-6 pb-6">
      {/* Header */}
      <div className="space-y-1">
        <h2>Ajustes</h2>
        <p className="text-muted-foreground">Personaliza tu experiencia</p>
      </div>

      {/* Appearance */}
      <Card className="p-4 border-0 shadow-sm">
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <Palette className="w-5 h-5 text-muted-foreground" />
            <h4>Apariencia</h4>
          </div>
          
          <Separator />
          
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                {darkMode ? (
                  <Moon className="w-5 h-5 text-muted-foreground" />
                ) : (
                  <Sun className="w-5 h-5 text-muted-foreground" />
                )}
                <div>
                  <Label>Tema oscuro</Label>
                  <p className="text-muted-foreground">Activa el modo nocturno</p>
                </div>
              </div>
              <Switch
                checked={darkMode}
                onCheckedChange={onToggleDarkMode}
              />
            </div>
          </div>
        </div>
      </Card>

      {/* Account */}
      <Card className="p-4 border-0 shadow-sm">
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <User className="w-5 h-5 text-muted-foreground" />
            <h4>Cuenta</h4>
          </div>
          
          <Separator />
          
          <div className="space-y-3">
            <button className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-accent transition-colors">
              <div className="flex items-center gap-3">
                <User className="w-5 h-5 text-muted-foreground" />
                <span>Editar perfil</span>
              </div>
            </button>
            
            <button className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-accent transition-colors">
              <div className="flex items-center gap-3">
                <Shield className="w-5 h-5 text-muted-foreground" />
                <span>Privacidad y seguridad</span>
              </div>
            </button>
          </div>
        </div>
      </Card>

      {/* Notifications */}
      <Card className="p-4 border-0 shadow-sm">
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <Bell className="w-5 h-5 text-muted-foreground" />
            <h4>Notificaciones</h4>
          </div>
          
          <Separator />
          
          <div className="flex items-center justify-between">
            <div>
              <Label>Notificaciones push</Label>
              <p className="text-muted-foreground">Recibe alertas importantes</p>
            </div>
            <Switch defaultChecked />
          </div>
        </div>
      </Card>

      {/* Support */}
      <Card className="p-4 border-0 shadow-sm">
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <HelpCircle className="w-5 h-5 text-muted-foreground" />
            <h4>Soporte</h4>
          </div>
          
          <Separator />
          
          <div className="space-y-3">
            <button className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-accent transition-colors">
              <div className="flex items-center gap-3">
                <HelpCircle className="w-5 h-5 text-muted-foreground" />
                <span>Centro de ayuda</span>
              </div>
            </button>
            
            <button className="w-full flex items-center justify-between p-3 rounded-lg hover:bg-accent transition-colors text-destructive">
              <div className="flex items-center gap-3">
                <LogOut className="w-5 h-5" />
                <span>Cerrar sesión</span>
              </div>
            </button>
          </div>
        </div>
      </Card>

      {/* Version */}
      <div className="text-center text-muted-foreground">
        <p>Azzuna v1.0.0</p>
      </div>
    </div>
  );
}
