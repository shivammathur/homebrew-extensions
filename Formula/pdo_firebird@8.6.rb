# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.6.0.tar.xz"
  sha256 "5f84beaa3d763aee1e4feed99bf54ec692c383b322e25626807b589238c3a087"
  revision 4
  head "https://github.com/php/php-src.git", branch: "PHP-8.6"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.6(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "0ba698d8dd935b09384089298d44704b7be32f46816eb45c4715be949a1bb194"
    sha256 cellar: :any, arm64_golden_gate: "90408a6d53a5ac949e0dc34c9573e226d5accb46c40f52c2976734ebdd3dc0b1"
    sha256 cellar: :any, arm64_tahoe:       "c8b89b8c91dad5c6a962f605665d7b0e4e93ea1370c416975df514410e02dfb8"
    sha256 cellar: :any, arm64_sequoia:     "6d8915482169a831e0d4bede66ddc86542aa0f48af0d6b72dfc8d777e587aa94"
    sha256 cellar: :any, arm64_linux:       "7dbcb55059aefc59b402bae2fd462e83c953fe894b227b4803ab1e4e56a12165"
    sha256 cellar: :any, x86_64_linux:      "0603808789f4b982663b9db1a9729b558e518614fd93a8c28f55b879905867df"
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
