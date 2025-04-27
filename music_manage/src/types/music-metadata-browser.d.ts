declare module 'music-metadata-browser' {
  interface ICommonTagsResult {
    title?: string;
    album?: string;
    artist?: string;
    year?: number;
    track?: { no: number; of: number };
    genre?: string[];
    picture?: Array<{
      format: string;
      data: Uint8Array;
      description?: string;
      type?: string;
    }>;
    lyrics?: string[];
  }

  interface IFormat {
    duration?: number;
    sampleRate?: number;
    bitrate?: number;
    numberOfChannels?: number;
    codecProfile?: string;
    lossless?: boolean;
  }

  interface INativeTagsResult {
    'ID3v2.3'?: Array<{
      id: string;
      value: {
        text?: string;
        description?: string;
        [key: string]: any;
      };
    }>;
    'ID3v2.4'?: Array<{
      id: string;
      value: {
        text?: string;
        description?: string;
        [key: string]: any;
      };
    }>;
  }

  interface IAudioMetadata {
    common: ICommonTagsResult;
    format: IFormat;
    native?: INativeTagsResult;
  }

  export function parseBlob(blob: Blob): Promise<IAudioMetadata>;
  export function parseBuffer(buf: Uint8Array, fileType?: string): Promise<IAudioMetadata>;
  export function fetchFromUrl(audioTrackUrl: string): Promise<IAudioMetadata>;
} 