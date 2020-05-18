//LLIUREX. Added videoCount
export default function readingTime({wordCount, imageCount,videoCount}) {
    let wordsPerMinute = 275;
    let wordsPerSecond = wordsPerMinute / 60;
    let minute = '1 min read';
    let minutes = '% min read';

    let readingTimeSeconds = wordCount / wordsPerSecond;

    for (var i = 12; i > 12 - imageCount; i -= 1) {
        // add 12 seconds for the first image, 11 for the second, etc. limiting at 3
        readingTimeSeconds += Math.max(i, 3);
    }
    for (var i = 12; i > 12 - videoCount; i -= 1) {
        // add 12 seconds for the first video, 11 for the second, etc. limiting at 3
        readingTimeSeconds += Math.max(i, 3);
    }

    let readingTimeMinutes = Math.round(readingTimeSeconds / 60);

    if (readingTimeMinutes < 1) {
        return minute;
    } else {
        return minutes.replace('%', readingTimeMinutes);
    }
}
