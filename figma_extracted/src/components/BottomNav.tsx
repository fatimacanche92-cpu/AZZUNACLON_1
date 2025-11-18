import { Home, Library, Image, Settings, Plus } from 'lucide-react';

type TabType = 'home' | 'library' | 'gallery' | 'settings';

interface BottomNavProps {
  activeTab: TabType;
  onTabChange: (tab: TabType) => void;
  onAddClick?: () => void;
}

export function BottomNav({ activeTab, onTabChange, onAddClick }: BottomNavProps) {
  const tabs = [
    { id: 'home' as TabType, label: 'Hogar', icon: Home },
    { id: 'library' as TabType, label: 'Biblioteca', icon: Library },
    { id: 'gallery' as TabType, label: 'Galería', icon: Image },
    { id: 'settings' as TabType, label: 'Ajustes', icon: Settings },
  ];

  return (
    <div className="fixed bottom-0 left-0 right-0 bg-background border-t border-border">
      <div className="max-w-lg mx-auto grid grid-cols-5 relative">
        {/* First two tabs */}
        {tabs.slice(0, 2).map((tab) => {
          const Icon = tab.icon;
          const isActive = activeTab === tab.id;
          
          return (
            <button
              key={tab.id}
              onClick={() => onTabChange(tab.id)}
              className={`flex flex-col items-center gap-1 py-3 transition-colors ${
                isActive
                  ? 'text-primary'
                  : 'text-muted-foreground hover:text-foreground'
              }`}
            >
              <Icon className="w-5 h-5" />
              <span className="text-xs">{tab.label}</span>
            </button>
          );
        })}

        {/* Center Add button */}
        <div className="flex items-center justify-center">
          <button
            onClick={onAddClick}
            className="absolute -top-6 bg-gradient-to-br from-[#E879F9] to-[#7C3AED] text-white rounded-full p-4 shadow-lg hover:shadow-xl transition-all hover:scale-105 active:scale-95"
          >
            <Plus className="w-7 h-7" />
          </button>
        </div>

        {/* Last two tabs */}
        {tabs.slice(2, 4).map((tab) => {
          const Icon = tab.icon;
          const isActive = activeTab === tab.id;
          
          return (
            <button
              key={tab.id}
              onClick={() => onTabChange(tab.id)}
              className={`flex flex-col items-center gap-1 py-3 transition-colors ${
                isActive
                  ? 'text-primary'
                  : 'text-muted-foreground hover:text-foreground'
              }`}
            >
              <Icon className="w-5 h-5" />
              <span className="text-xs">{tab.label}</span>
            </button>
          );
        })}
      </div>
    </div>
  );
}