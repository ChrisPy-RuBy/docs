def compress(raw: str) -> bytes:
    """
    Compress the raw string to bytes using RLE.
    """
    results = []
    encoded = raw.encode('utf-8')
    print(encoded)

    for pointer in encoded:
         print(pointer)
         if not results:
             results.append([pointer])
             continue

         if pointer in set(results[-1]):
             results[-1].append(pointer)
         else:
             results.append([pointer])
    print(results)

    result = b"".join([len(string_count).to_bytes(1, 'big') + string_count[0].to_bytes(1, 'big')
                      for string_count in results])
    return result
