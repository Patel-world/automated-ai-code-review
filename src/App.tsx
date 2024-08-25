import React from 'react';
import BlogPage from './components/BlogPage';
import './index.css'; // Make sure Tailwind CSS is imported

const App: React.FC = () => {
  return (
    <div className="App">
      <BlogPage />
    </div>
  );
};

export default App;
