part of opensubtitles_api;

class FileInfo {
  int byteSize;
  String hash;
}

Future<FileInfo> computeHash(File file) {
  return file.length().then((int size) {
    int chunkSize = min(_HASH_CHUNK_SIZE, size);

    return Future.wait([_checksum(file, 0, chunkSize), _checksum(file, size -
        chunkSize, size)]).then((List<Int64> res) {
      return new FileInfo()
          ..byteSize = size
          ..hash = (res[0] + res[1] + size).toHexString().toLowerCase();
    });
  });
}

Future<Int64> _checksum(File file, int from, int to) {
  Int64 hash = new Int64(0);
  return file.openRead(from, to).first.then((List<int> data) {
    for (int i = 0; i < data.length; i += 8) {
      hash += new Int64.fromBytes(data.sublist(i, i + 8));
    }
    return hash;
  });
}
