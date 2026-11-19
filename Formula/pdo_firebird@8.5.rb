# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.13.tar.xz"
  sha256 "607602acaf0c3061818e9916ec44a058e8b3d43959a83862b9cd3ec7bf5b785f"
  head "https://github.com/php/php-src.git", branch: "PHP-8.5"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.5(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "5bbd3ecfa1c054dd58fa75449efa6beef93119930383e1af22efa317df64cede"
    sha256 cellar: :any, arm64_tahoe:       "038dcbc4044a0221e9dee2391501696fb1516c2076052660282e18355d9e8c7f"
    sha256 cellar: :any, arm64_sequoia:     "204904de6a1059e8d6d14150c79dd8673e6e9a41357c11f30bdce3d82dc4baf0"
    sha256 cellar: :any, arm64_linux:       "b03bdb4171e25f3a06627b0fa3d362636a788614b12efea25fade87af666e84b"
    sha256 cellar: :any, x86_64_linux:      "df355e2dd9a5cad05d32a8a3d2eceb61aeef91080af3fbf15d06daad06b90d32"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
