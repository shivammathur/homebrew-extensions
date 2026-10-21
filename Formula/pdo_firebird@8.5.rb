# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.12.tar.xz"
  sha256 "08bc2eba2a588654ade1357174aa646b761556c862dda0678345ee29ed481209"
  head "https://github.com/php/php-src.git", branch: "PHP-8.5"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.5(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "206e54a20f2214970fc9cf8637edee2829cc2d8ce8d16d8ecbfc5644e2161e32"
    sha256 cellar: :any, arm64_tahoe:       "48566644bc73b97fffaa6f2d9281594a75bceafdc916b7ceab27cceb11951d77"
    sha256 cellar: :any, arm64_sequoia:     "27071d4ae675a3c2a576562cc93f3e9b02a16651b0eac9c5cc643f354eca857f"
    sha256 cellar: :any, arm64_linux:       "c73f831b1c7bb66d2b94cdc0486a95903cf5fe4c6f734f7f28750777b2bc6b13"
    sha256 cellar: :any, x86_64_linux:      "ab549ea5b977ce0de725f130f9c90c06780e93fdd52778bd44e708d3c517ceba"
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
