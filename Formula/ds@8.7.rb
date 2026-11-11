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
  revision 1
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "6dbff562b21878f37f7d486329d86241088957ec00ba93c94e9e7d441cf3f5f4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "b417b4e27b00b49360b7ba07e5937222a81ed996d76220b801ea681e3aba07ff"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "7901c46c012c36cfbbd9967b6d5e70a167acc2553ba7175458d571f9d22ea5de"
    sha256 cellar: :any,                 arm64_linux:       "cd3277037e502a7e660e454e7240168591c798886ec5a0377304dbd922c1ef3f"
    sha256 cellar: :any,                 x86_64_linux:      "41152d3f5b3737ace44de10f658c6191cc65d3f94ae58fc8ec2381f4aa21a969"
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
