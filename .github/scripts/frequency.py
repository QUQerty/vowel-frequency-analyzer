import sys
from collections import Counter

VOWELS = "aeiou"


def count_vowels(file_path):
    """Read the file, lowercase it, and count how often each vowel appears."""
    try:
        with open(file_path, "r") as handle:
            text = handle.read().lower()
    except FileNotFoundError:
        print("Error: file not found: {}".format(file_path))
        sys.exit(1)

    counts = Counter(character for character in text if character in VOWELS)
    return {vowel: counts.get(vowel, 0) for vowel in VOWELS}


def main():
    if len(sys.argv) != 2:
        print("Usage: python3 frequency.py <file_path>")
        sys.exit(1)

    result = count_vowels(sys.argv[1])
    print(", ".join("{}: {}".format(vowel, total) for vowel, total in result.items()))


if __name__ == "__main__":
    main()
