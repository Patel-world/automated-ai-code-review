import React from 'react';
import './index.css'; // Make sure Tailwind CSS is imported
import BlogPage from './components/blog.page';

const App: React.FC = () => {
  return (
    <div className="App">
      <BlogPage />
    </div>
  );
};

export default App;
