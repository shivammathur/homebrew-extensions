# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT84 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "1600cc9deb37461f79fa158fe3aeb3b426793ffc4b0a926a86d173efaa7ef8c7"
    sha256 cellar: :any,                 arm64_sequoia: "434d41669032d3ea40164f084e24de3f013cd72a6dd46055d521c9cc70f1af78"
    sha256 cellar: :any,                 arm64_sonoma:  "4f98c736ce0505bd1749a63a021b31c3f9b047466894dbdefff6edd8f49fd619"
    sha256 cellar: :any,                 sonoma:        "2290048516957223a2155a7dd3699227e732b4a258ed568d2012fcad5f96674b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a0edfeb59acbb9f52a7b063dc4a4052c16656f0dd6b513ba1ae0b6b6e932aa8d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1153476af7cb0481fc60e5f67ecbf6f1ed17759c7bd724f87c5ece748178d364"
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
