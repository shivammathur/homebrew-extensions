# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT86 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-2.0.0.tgz"
  sha256 "52dfed624fbca90ad9e426f7f91a0929db3575a1b8ff6ea0cf2606b7edbc3940"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "efa653747352eb0dd93db67b5f0764b9ceeacb2ae4b0088ab68ba3ba813b67fb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1680b550928242296ced1ffe6b4064007c0a6780579ed3f1d94730afc08a3caa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "23b712861c954b49e5f5ed6941eca93c36cf8408a47629cdd81d4d4374f755e3"
    sha256 cellar: :any_skip_relocation, sonoma:        "283a69757a414ecfecce773d773f971d36753d530b546b443118eade1af19219"
    sha256 cellar: :any,                 arm64_linux:   "c44ffee233da592f152601b523d27afba9e3f6da0a827be702a692abd16171ce"
    sha256 cellar: :any,                 x86_64_linux:  "7bbf0a8353a4ef626fa9c64fb6fab330ba30c08caa54a1115282d62fe7091e7a"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace %w[
      src/php/handlers/php_heap_handlers.c
      src/php/handlers/php_map_handlers.c
      src/php/handlers/php_pair_handlers.c
      src/php/handlers/php_seq_handlers.c
      src/php/handlers/php_set_handlers.c
      src/php/objects/php_heap.h
      src/php/objects/php_map.h
      src/php/objects/php_seq.h
      src/php/objects/php_set.h
    ], "XtOffsetOf", "offsetof"
    inreplace "src/php/handlers/php_seq_handlers.c",
              'if (zend_parse_parameter(ZEND_PARSE_PARAMS_QUIET, 1, offset, "l", &index) == FAILURE) {',
              "bool failed = false; index = zval_try_get_long(offset, &failed); if (failed) {"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
