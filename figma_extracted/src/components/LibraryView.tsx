import { ImageWithFallback } from './figma/ImageWithFallback';
import { Card } from './ui/card';
import { Calendar } from 'lucide-react';

const libraryGroups = [
  {
    id: 1,
    date: '4 de octubre, 2025',
    items: [
      {
        id: 1,
        image: 'https://images.unsplash.com/photo-1677653943284-34919235eb9a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmbG93ZXIlMjBhcnJhbmdlbWVudCUyMGJvdXF1ZXR8ZW58MXx8fHwxNzU5NjA1NTMzfDA&ixlib=rb-4.1.0&q=80&w=1080',
        title: 'Arreglo mixto'
      },
      {
        id: 2,
        image: 'https://images.unsplash.com/photo-1594851686676-36d218b89bf1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaW5rJTIwcm9zZXMlMjBhcnJhbmdlbWVudHxlbnwxfHx8fDE3NTk2MDU1MzV8MA&ixlib=rb-4.1.0&q=80&w=1080',
        title: 'Rosas rosadas'
      }
    ]
  },
  {
    id: 2,
    date: '3 de octubre, 2025',
    items: [
      {
        id: 3,
        image: 'https://images.unsplash.com/photo-1631084854605-2ea7de264ebf?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmbG9yYWwlMjBnaWZ0JTIwYm94fGVufDF8fHx8MTc1OTYwNTUzNHww&ixlib=rb-4.1.0&q=80&w=1080',
        title: 'Caja de regalo floral'
      }
    ]
  },
  {
    id: 3,
    date: '1 de octubre, 2025',
    items: [
      {
        id: 4,
        image: 'https://images.unsplash.com/photo-1743281181949-51fa68f5d71a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0dWxpcCUyMGFycmFuZ2VtZW50JTIwc3ByaW5nfGVufDF8fHx8MTc1OTYwNTUzOXww&ixlib=rb-4.1.0&q=80&w=1080',
        title: 'Tulipanes primaverales'
      },
      {
        id: 5,
        image: 'https://images.unsplash.com/photo-1752765579894-9a7aef6fb359?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzdW5mbG93ZXIlMjBib3VxdWV0JTIwYnJpZ2h0fGVufDF8fHx8MTc1OTYwNTUzOXww&ixlib=rb-4.1.0&q=80&w=1080',
        title: 'Girasoles brillantes'
      }
    ]
  }
];

export function LibraryView() {
  return (
    <div className="space-y-6 pb-6">
      {/* Header */}
      <div className="space-y-1">
        <h2>Biblioteca</h2>
        <p className="text-muted-foreground">Organizado por fecha de captura</p>
      </div>

      {/* Grouped by date */}
      <div className="space-y-6">
        {libraryGroups.map((group) => (
          <div key={group.id} className="space-y-3">
            <div className="flex items-center gap-2 text-muted-foreground">
              <Calendar className="w-4 h-4" />
              <span>{group.date}</span>
            </div>
            <div className="grid grid-cols-2 gap-3">
              {group.items.map((item) => (
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
          </div>
        ))}
      </div>
    </div>
  );
}
