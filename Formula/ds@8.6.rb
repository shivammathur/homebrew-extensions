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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ea03761cad0e3e741229ce6a1bf87cf580462ecead62c9bd50f98a7ef9c40d48"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4038e1328a49d5a4a28e02e7db704e55090ee305e7657f910c98cb75f45c796f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ba36fb62209dfbd64f166b6d822d4b147c514afbe899aafe10951dbda3965779"
    sha256 cellar: :any_skip_relocation, sonoma:        "a0ff78f45a72e6d6df7dae41cae7455fdf99e381018c628aa86f36509f1b19f0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c3f6f3edc6d51bad1c1c58522cd3e4b92a690f50149807d0dab5b894ce8f6dc7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da2c6622f469d2c4599d460aea91572fc0c92b8b85be579526cf3d004fe96320"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
