# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT87 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-2.0.0.tgz"
  sha256 "52dfed624fbca90ad9e426f7f91a0929db3575a1b8ff6ea0cf2606b7edbc3940"
  revision 2
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "2643b856c5b5da6b1ea25871a1c42f040dafb64a879d6f0144612a538734dd2b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "145e66b01b0e95bbbbd2eed4bce1da42f4d71c18a79ae42bad27c3362b3ba242"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "5ffbcff09b1aeb479fae4830762de792e5e5ad6c0f374a1ec91ad0ba1a4e3428"
    sha256 cellar: :any,                 arm64_linux:       "270000eba1f0256be51c1836f63c01d3975a1273abea924feb2efa98fdcf6e59"
    sha256 cellar: :any,                 x86_64_linux:      "27fa1046915f2bd29c537b2124cec9c33b7ffccf3b78178eb399b79a99177bcf"
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
