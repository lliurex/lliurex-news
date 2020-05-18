export default function missingMessage(key, locales, options) {
    // eslint-disable-next-line no-console
    console.warn(`Missing translation for key: "${key}" for locales: "${locales}"; ${JSON.stringify(options)}`);
    return key;
}