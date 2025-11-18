import { useState, useEffect } from 'react';
import { LoginScreen } from './components/LoginScreen';
import { SignUpScreen } from './components/SignUpScreen';
import { WelcomeScreen } from './components/WelcomeScreen';
import { HomeView } from './components/HomeView';
import { LibraryView } from './components/LibraryView';
import { GalleryView } from './components/GalleryView';
import { SettingsView } from './components/SettingsView';
import { BottomNav } from './components/BottomNav';
import { Flower2 } from 'lucide-react';

type Screen = 'login' | 'signup' | 'welcome' | 'main';
type TabType = 'home' | 'library' | 'gallery' | 'settings';

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>('login');
  const [userEmail, setUserEmail] = useState('');
  const [userName, setUserName] = useState('');
  const [activeTab, setActiveTab] = useState<TabType>('home');
  const [darkMode, setDarkMode] = useState(false);

  // Toggle dark mode
  useEffect(() => {
    if (darkMode) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, [darkMode]);

  const handleLogin = (email: string) => {
    setUserEmail(email);
    setCurrentScreen('welcome');
  };

  const handleSignUp = (email: string, name: string) => {
    setUserEmail(email);
    setUserName(name);
    setCurrentScreen('welcome');
  };

  const handleWelcomeComplete = () => {
    setCurrentScreen('main');
  };

  const handleToggleDarkMode = () => {
    setDarkMode(!darkMode);
  };

  const handleAddClick = () => {
    // Funcionalidad para agregar nuevo arreglo/foto
    alert('Funcionalidad de agregar foto o arreglo');
  };

  // Login Screen
  if (currentScreen === 'login') {
    return <LoginScreen onLogin={handleLogin} onSignUpClick={() => setCurrentScreen('signup')} />;
  }

  // Sign Up Screen
  if (currentScreen === 'signup') {
    return <SignUpScreen onSignUp={handleSignUp} onBackToLogin={() => setCurrentScreen('login')} />;
  }

  // Welcome Screen
  if (currentScreen === 'welcome') {
    return <WelcomeScreen email={userEmail} onComplete={handleWelcomeComplete} />;
  }

  // Main Screen
  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <header className="sticky top-0 z-10 bg-background border-b border-border">
        <div className="max-w-lg mx-auto px-6 py-4">
          <div className="flex items-center gap-2">
            <div className="bg-primary rounded-lg p-2 relative overflow-hidden">
              <Flower2 className="w-5 h-5 text-primary-foreground relative z-10" />
              {/* Sparkles/brillitos */}
              <div className="absolute top-0 left-0 w-1 h-1 bg-white rounded-full opacity-90 animate-pulse" style={{ animationDelay: '0s' }}></div>
              <div className="absolute top-1 right-1 w-1 h-1 bg-white rounded-full opacity-80 animate-pulse" style={{ animationDelay: '0.3s' }}></div>
              <div className="absolute bottom-1 left-1.5 w-0.5 h-0.5 bg-white rounded-full opacity-70 animate-pulse" style={{ animationDelay: '0.6s' }}></div>
            </div>
            <h3 className="text-primary">Azzuna</h3>
          </div>
        </div>
      </header>

      {/* Content */}
      <main className="max-w-lg mx-auto px-6 pt-6 pb-24">
        {activeTab === 'home' && <HomeView />}
        {activeTab === 'library' && <LibraryView />}
        {activeTab === 'gallery' && <GalleryView />}
        {activeTab === 'settings' && (
          <SettingsView darkMode={darkMode} onToggleDarkMode={handleToggleDarkMode} />
        )}
      </main>

      {/* Bottom Navigation */}
      <BottomNav activeTab={activeTab} onTabChange={setActiveTab} onAddClick={handleAddClick} />
    </div>
  );
}