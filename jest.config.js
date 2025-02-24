module.exports = {
  preset: 'jest-preset-angular',
  // setupFilesAfterEnv: ['<rootDir>/setup-jest.ts'], // Certifique-se de que está assim
  globalSetup: 'jest-preset-angular/global-setup',
  testPathIgnorePatterns: ['<rootDir>/node_modules/', '<rootDir>/dist/'],
  moduleNameMapper: {
    '^src/(.*)$': '<rootDir>/src/$1',
  },
};
