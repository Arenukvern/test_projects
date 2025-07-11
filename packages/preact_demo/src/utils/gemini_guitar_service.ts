// geminiGuitar.service.ts
// This service fetches and parses guitar sheet data from the Gemini API
// and provides a utility function to sync it with audio playback.

// -----------------------------------------------------------------------------
// #region DATA STRUCTURES (TYPES)
// -----------------------------------------------------------------------------

/**
 * Represents a single note on the guitar.
 * 'string' is the guitar string number (1-6, where 1 is the high E).
 */
export interface GuitarNote {
  string: 1 | 2 | 3 | 4 | 5 | 6;
  fret: number;
}

/**
 * Represents a musical event in the guitar sheet.
 * This can be a single note or a chord.
 */
export interface GuitarTabSection {
  type: "chord" | "note";
  /** The name of the chord (e.g., "G", "Am7") or note (e.g., "E4"). */
  name: string;
  /** The notes that make up this section. An array for chords, a single-element array for a note. */
  notes: GuitarNote[];
  /** The start time of this section in seconds from the beginning of the song. */
  startTime: number;
  /** The duration of this section in seconds. */
  duration: number;
}

/**
 * The complete guitar sheet, represented as an array of timed sections.
 */
export type GuitarSheet = GuitarTabSection[];

// -----------------------------------------------------------------------------
// #endregion
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// #region GEMINI GUITAR SERVICE
// -----------------------------------------------------------------------------

export class GeminiGuitarService {
  private apiKey: string;
  private geminiApiUrl =
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";

  /**
   * ⚠️ SECURITY WARNING ⚠️
   * Do not expose your API key on the client-side in a production application.
   * This class is designed for rapid prototyping. In production, you should
   * make this API call from a secure backend server (e.g., a serverless function)
   * that proxies the request to the Google AI API.
   *
   * @param apiKey Your Google AI Studio API key.
   */
  constructor(apiKey: string) {
    if (!apiKey) {
      throw new Error("Gemini API key is required.");
    }
    this.apiKey = apiKey;
  }

  /**
   * Generates a structured GuitarSheet from a text prompt.
   * @param musicPrompt A prompt describing the music to be transcribed.
   * e.g., "Generate simple guitar tabs for the first 8 bars of 'Twinkle Twinkle Little Star' in the key of G."
   * @returns A promise that resolves to a GuitarSheet array.
   */
  public async generateSheetFromPrompt(
    musicPrompt: string
  ): Promise<GuitarSheet> {
    // This prompt engineers the AI to return a specific JSON format.
    const fullPrompt = `
      You are an expert musician and AI assistant specializing in guitar tablature.
      Analyze the following request and generate a guitar sheet.
      The output MUST be a valid JSON array that conforms to the GuitarSheet type definition below.
      Do not include any text, explanation, or markdown formatting outside of the JSON array itself.

      Type Definitions:
      type GuitarSheet = GuitarTabSection[];
      type GuitarTabSection = {
        type: 'chord' | 'note';
        name: string; // e.g., "G", "C", "A4"
        notes: { string: number; fret: number; }[];
        startTime: number; // in seconds
        duration: number; // in seconds
      };

      Request: "${musicPrompt}"
    `;

    try {
      const response = await fetch(`${this.geminiApiUrl}?key=${this.apiKey}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          contents: [{ parts: [{ text: fullPrompt }] }],
        }),
      });

      if (!response.ok) {
        const errorBody = await response.json();
        console.error("Gemini API Error:", errorBody);
        throw new Error(
          `Gemini API request failed with status ${response.status}`
        );
      }

      const responseData = await response.json();
      const rawText = responseData.candidates?.[0]?.content?.parts?.[0]?.text;

      if (!rawText) {
        throw new Error("Failed to extract content from Gemini response.");
      }

      // The response might be wrapped in markdown backticks.
      const cleanedJson = rawText.replace(/^```json\s*|```$/g, "").trim();

      // Parse the cleaned JSON string into our structured GuitarSheet type.
      const parsedSheet: GuitarSheet = JSON.parse(cleanedJson);
      return parsedSheet;
    } catch (error) {
      console.error("Error generating or parsing guitar sheet:", error);
      // Return an empty array or re-throw to be handled by the caller.
      return [];
    }
  }

  /**
   * Finds the currently active section of a guitar sheet based on playback time.
   * @param sheet The GuitarSheet data to search within.
   * @param currentTime The current playback time of the audio in seconds.
   * @returns The active GuitarTabSection or null if no section is active at the given time.
   */
  public findCurrentSection(
    sheet: GuitarSheet,
    currentTime: number
  ): GuitarTabSection | null {
    // Use findLast to correctly identify the section if the user seeks backwards.
    const activeSection = sheet.find(
      (section) =>
        currentTime >= section.startTime &&
        currentTime < section.startTime + section.duration
    );
    return activeSection || null;
  }
}
// -----------------------------------------------------------------------------
// #endregion
// -----------------------------------------------------------------------------
