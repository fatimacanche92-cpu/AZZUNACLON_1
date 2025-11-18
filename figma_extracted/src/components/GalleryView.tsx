import { ImageWithFallback } from './figma/ImageWithFallback';
import { Card } from './ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from './ui/tabs';

const categories = {
  arreglos: [
    {
      id: 1,
      image: 'https://images.unsplash.com/photo-1677653943284-34919235eb9a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmbG93ZXIlMjBhcnJhbmdlbWVudCUyMGJvdXF1ZXR8ZW58MXx8fHwxNzU5NjA1NTMzfDA&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Bouquet clásico'
    },
    {
      id: 2,
      image: 'https://images.unsplash.com/photo-1594851686676-36d218b89bf1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaW5rJTIwcm9zZXMlMjBhcnJhbmdlbWVudHxlbnwxfHx8fDE3NTk2MDU1MzV8MA&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Rosas rosadas'
    },
    {
      id: 3,
      image: 'https://images.unsplash.com/photo-1743281181949-51fa68f5d71a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0dWxpcCUyMGFycmFuZ2VtZW50JTIwc3ByaW5nfGVufDF8fHx8MTc1OTYwNTUzOXww&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Tulipanes primavera'
    },
    {
      id: 4,
      image: 'https://images.unsplash.com/photo-1752765579894-9a7aef6fb359?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzdW5mbG93ZXIlMjBib3VxdWV0JTIwYnJpZ2h0fGVufDF8fHx8MTc1OTYwNTUzOXww&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Girasoles alegres'
    },
    {
      id: 5,
      image: 'https://images.unsplash.com/photo-1758720248299-031d55aed3ff?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxvcmNoaWQlMjBlbGVnYW50JTIwZmxvd2Vyc3xlbnwxfHx8fDE3NTk2MDU1Mzl8MA&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Orquídeas elegantes'
    },
    {
      id: 6,
      image: 'https://images.unsplash.com/photo-1730123481681-82a244d7cfc5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxyb3NlJTIwYm91cXVldCUyMHJvbWFudGljfGVufDF8fHx8MTc1OTYwNTUzNXww&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Rosas románticas'
    }
  ],
  regalos: [
    {
      id: 7,
      image: 'https://images.unsplash.com/photo-1631084854605-2ea7de264ebf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmbG9yYWwlMjBnaWZ0JTIwYm94fGVufDF8fHx8MTc1OTYwNTUzNHww&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Caja regalo floral'
    },
    {
      id: 8,
      image: 'https://images.unsplash.com/photo-1604925828072-87e23dde39eb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxiaXJ0aGRheSUyMGZsb3dlcnMlMjBjZWxlYnJhdGlvbnxlbnwxfHx8fDE3NTk1MDc4MTB8MA&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Celebración especial'
    },
    {
      id: 9,
      image: 'https://images.unsplash.com/photo-1594851686676-36d218b89bf1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaW5rJTIwcm9zZXMlMjBhcnJhbmdlbWVudHxlbnwxfHx8fDE3NTk2MDU1MzV8MA&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Detalle romántico'
    },
    {
      id: 10,
      image: 'https://images.unsplash.com/photo-1752765579894-9a7aef6fb359?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzdW5mbG93ZXIlMjBib3VxdWV0JTIwYnJpZ2h0fGVufDF8fHx8MTc1OTYwNTUzOXww&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Regalo cumpleaños'
    }
  ],
  eventos: [
    {
      id: 11,
      image: 'https://images.unsplash.com/photo-1684243920725-956d93ff391a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx3ZWRkaW5nJTIwZmxvd2VycyUyMGRlY29yYXRpb258ZW58MXx8fHwxNzU5NjA1NTM0fDA&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Decoración boda'
    },
    {
      id: 12,
      image: 'https://images.unsplash.com/photo-1751891076185-cced7f1cc007?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmbG93ZXIlMjBjZW50ZXJwaWVjZSUyMGV2ZW50fGVufDF8fHx8MTc1OTYwNTU0MHww&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Centro de mesa'
    },
    {
      id: 13,
      image: 'https://images.unsplash.com/photo-1677653943284-34919235eb9a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmbG93ZXIlMjBhcnJhbmdlbWVudCUyMGJvdXF1ZXR8ZW58MXx8fHwxNzU5NjA1NTMzfDA&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Evento corporativo'
    },
    {
      id: 14,
      image: 'https://images.unsplash.com/photo-1743281181949-51fa68f5d71a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0dWxpcCUyMGFycmFuZ2VtZW50JTIwc3ByaW5nfGVufDF8fHx8MTc1OTYwNTUzOXww&ixlib=rb-4.1.0&q=80&w=1080',
      title: 'Fiesta primaveral'
    }
  ]
};

export function GalleryView() {
  return (
    <div className="space-y-6 pb-6">
      {/* Header */}
      <div className="space-y-1">
        <h2>Galería</h2>
        <p className="text-muted-foreground">Clasificadas por categoría</p>
      </div>

      {/* Tabs */}
      <Tabs defaultValue="arreglos" className="w-full">
        <TabsList className="w-full grid grid-cols-3">
          <TabsTrigger value="arreglos">Arreglos</TabsTrigger>
          <TabsTrigger value="regalos">Regalos</TabsTrigger>
          <TabsTrigger value="eventos">Eventos</TabsTrigger>
        </TabsList>
        
        <TabsContent value="arreglos" className="mt-6">
          <div className="grid grid-cols-2 gap-3">
            {categories.arreglos.map((item) => (
              <Card key={item.id} className="overflow-hidden border-0 shadow-sm">
                <div className="aspect-square bg-muted">
                  <ImageWithFallback
                    src={item.image}
                    alt={item.title}
                    className="w-full h-full object-cover"
                  />
                </div>
                <div className="p-3">
                  <p className="truncate">{item.title}</p>
                </div>
              </Card>
            ))}
          </div>
        </TabsContent>

        <TabsContent value="regalos" className="mt-6">
          <div className="grid grid-cols-2 gap-3">
            {categories.regalos.map((item) => (
              <Card key={item.id} className="overflow-hidden border-0 shadow-sm">
                <div className="aspect-square bg-muted">
                  <ImageWithFallback
                    src={item.image}
                    alt={item.title}
                    className="w-full h-full object-cover"
                  />
                </div>
                <div className="p-3">
                  <p className="truncate">{item.title}</p>
                </div>
              </Card>
            ))}
          </div>
        </TabsContent>

        <TabsContent value="eventos" className="mt-6">
          <div className="grid grid-cols-2 gap-3">
            {categories.eventos.map((item) => (
              <Card key={item.id} className="overflow-hidden border-0 shadow-sm">
                <div className="aspect-square bg-muted">
                  <ImageWithFallback
                    src={item.image}
                    alt={item.title}
                    className="w-full h-full object-cover"
                  />
                </div>
                <div className="p-3">
                  <p className="truncate">{item.title}</p>
                </div>
              </Card>
            ))}
          </div>
        </TabsContent>
      </Tabs>
    </div>
  );
}
