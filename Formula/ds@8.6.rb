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
  revision 1
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "e0ca3480fc6add0200c9f4b472c0f8cc5f71146cd7aa2fd1eee1832d886cf80d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "ee17461106593ca75e4abd4475830e6dd0e596d8e9f771c0f0411a34613b6e0a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "0fbb5c22c7cdf95e22a7aac316b078e99ec69556100a21a95b56168a6e1c426b"
    sha256 cellar: :any,                 arm64_linux:       "039675b2a9af85fcffedd1043641cab2919deb07d34cf4837811a8c51a7ae0a6"
    sha256 cellar: :any,                 x86_64_linux:      "b25870196264e687ca2c4a353d51e1af6cf3786ea9fe3d359662691cf8f648d3"
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
