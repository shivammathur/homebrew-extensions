# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "48ca2e072ba2708dd96a9352308ee6ec45bb131250eb0a0882320546d5f45a37"
    sha256 cellar: :any,                 arm64_sequoia: "9877fed4e93cf75e539f3eb30f29fa5318db98e5493dbe4c0f92a1794513d0da"
    sha256 cellar: :any,                 arm64_sonoma:  "9dce65b5da122a3a14dc89f9a3e8d9e48abf5cd67489a90a42c32b2ce40c8e96"
    sha256 cellar: :any,                 sonoma:        "bc38b40e7c12773cbc28a96bc84a429a8f035ca1823963f2bceb732c9861234a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b88a17251d640833b524d08f444b765955dbed202e52a7bcfe5b682ac77d7394"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0da9bbb0aa2f7f8d45eb4b62e285976312aa397bc4ab8cc691f21b43205962f"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/FirebirdSQL/php-firebird"
  url "https://github.com/FirebirdSQL/php-firebird/archive/refs/tags/v6.1.1-RC.2.tar.gz"
  sha256 "ed1ef8a722e26e1c7123079af7b60d19475ba7bd7f2c8f02f8ae2a31c83828e8"
  license "PHP-3.01"

  livecheck do
    url "https://github.com/FirebirdSQL/php-firebird/tags"
    regex(/^v?(\d+(?:\.\d+)+(?:[-._][A-Za-z0-9._-]+)?)$/i)
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    inreplace "ibase_events.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    inreplace "ibase_blobs.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
