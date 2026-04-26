# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e3d9b568296d47f6daad6669a8f3a7887c04740274cb66b55a8f7fa2392a5b15"
    sha256 cellar: :any,                 arm64_sequoia: "fb87012864b548d2b09d44420c2d92445f09a6c17381044be8357580fb2499e2"
    sha256 cellar: :any,                 arm64_sonoma:  "4bd209fa8af3c284317ea536ec92a53ee6adeea1dec2af6f122203caab62df6a"
    sha256 cellar: :any,                 sonoma:        "281e5c2944670313947c707d50aab75c58d334ba5e63deeccbb2ada38cad10b9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "77a1f283b74b82d386fd9001c5810414dc9c5463861bf40a34145b55d0f91c68"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c9c43e75776bf01fdd101fab3b132f3f38cb665483e231a29fd4ff9a1a297843"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/FirebirdSQL/php-firebird"
  url "https://github.com/FirebirdSQL/php-firebird/archive/refs/tags/v6.1.1-RC.2.tar.gz"
  sha256 "ed1ef8a722e26e1c7123079af7b60d19475ba7bd7f2c8f02f8ae2a31c83828e8"
  revision 1
  license "PHP-3.01"

  livecheck do
    url "https://github.com/FirebirdSQL/php-firebird/tags"
    regex(/^v?(\d+(?:\.\d+)+(?:[-._][A-Za-z0-9._-]+)?)$/i)
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    inreplace "ibase_events.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    inreplace "ibase_blobs.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    inreplace %w[interbase.c ibase_query.c], "INI_STR(", "zend_ini_string_literal("
    inreplace %w[interbase.c ibase_query.c], "INI_INT(", "zend_ini_long_literal("
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
