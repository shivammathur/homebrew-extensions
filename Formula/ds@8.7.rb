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
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "a430b0c90a7ba6e9592d8f0962cb27c2251e99d8d1839a7b361ec2aaff95638c"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "85f9dfb60e176493b2823ae9ae255d988c7938817b13d81bda43a3643f7a72bb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "88f1fa08100c380b0c5fed3ab72e0e00977a1d4d952c369e42f4af4d38cd3902"
    sha256 cellar: :any,                 arm64_linux:       "6230b4c4cb4808bdd65470b157f52afe7168aa36ce9c774af982efb0d8cc869f"
    sha256 cellar: :any,                 x86_64_linux:      "7190fad4e22050b6a84066ac7b2c0bee13ba03c23d6cb832b7ede3ee8da083a1"
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
