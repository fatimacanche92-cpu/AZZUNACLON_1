import { ImageWithFallback } from './figma/ImageWithFallback';
import { Card } from './ui/card';
import { Badge } from './ui/badge';
import { Sparkles, TrendingUp } from 'lucide-react';

const featuredItems = [
  {
    id: 1,
    title: 'Rosas Románticas',
    image: 'https://images.unsplash.com/photo-1730123481681-82a244d7cfc5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxyb3NlJTIwYm91cXVldCUyMHJvbWFudGljfGVufDF8fHx8MTc1OTYwNTUzNXww&ixlib=rb-4.1.0&q=80&w=1080',
    badge: 'Nuevo',
    type: 'new'
  },
  {
    id: 2,
    title: 'Flores para Bodas',
    image: 'https://images.unsplash.com/photo-1684243920725-956d93ff391a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx3ZWRkaW5nJTIwZmxvd2VycyUyMGRlY29yYXRpb258ZW58MXx8fHwxNzU5NjA1NTM0fDA&ixlib=rb-4.1.0&q=80&w=1080',
    badge: 'Tendencia',
    type: 'trending'
  },
  {
    id: 3,
    title: 'Girasoles Alegres',
    image: 'https://images.unsplash.com/photo-1752765579894-9a7aef6fb359?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzdW5mbG93ZXIlMjBib3VxdWV0JTIwYnJpZ2h0fGVufDF8fHx8MTc1OTYwNTUzOXww&ixlib=rb-4.1.0&q=80&w=1080',
    badge: 'Nuevo',
    type: 'new'
  }
];

export function HomeView() {
  return (
    <div className="space-y-6 pb-6">
      {/* Header */}
      <div className="space-y-1">
        <h2>Inicio</h2>
        <p className="text-muted-foreground">Descubre tus arreglos florales</p>
      </div>

      {/* Featured Section */}
      <div className="space-y-4">
        <h3>Destacados</h3>
        <div className="grid gap-4">
          {featuredItems.map((item) => (
            <Card key={item.id} className="overflow-hidden border-0 shadow-sm">
              <div className="relative aspect-[16/9] bg-muted">
                <ImageWithFallback
                  src={item.image}
                  alt={item.title}
                  className="w-full h-full object-cover"
                />
                <div className="absolute top-3 left-3">
                  <Badge className="gap-1.5">
                    {item.type === 'new' ? (
                      <Sparkles className="w-3 h-3" />
                    ) : (
                      <TrendingUp className="w-3 h-3" />
                    )}
                    {item.badge}
                  </Badge>
                </div>
              </div>
              <div className="p-4">
                <h4>{item.title}</h4>
              </div>
            </Card>
          ))}
        </div>
      </div>

      {/* Quick Stats */}
      <div className="grid grid-cols-3 gap-3">
        <Card className="p-4 text-center border-0 shadow-sm">
          <div className="text-2xl">24</div>
          <p className="text-muted-foreground">Arreglos</p>
        </Card>
        <Card className="p-4 text-center border-0 shadow-sm">
          <div className="text-2xl">8</div>
          <p className="text-muted-foreground">Eventos</p>
        </Card>
        <Card className="p-4 text-center border-0 shadow-sm">
          <div className="text-2xl">12</div>
          <p className="text-muted-foreground">Regalos</p>
        </Card>
      </div>
    </div>
  );
}
