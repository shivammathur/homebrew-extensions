# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.9.tar.xz"
  sha256 "0db7855f25bcd0ab1d592cdb35e284d6f6a5d2ae0f6f621122e364cc39b708f4"
  head "https://github.com/php/php-src.git", branch: "PHP-8.5"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.5(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "e99d76f2c55efbb9c83ba8e7ff43266c67729c29b233c1a09d03e199c8f1f6b6"
    sha256 cellar: :any, arm64_sequoia: "50ea42452c5ad5769b6e6794526b4d636ff87a7542239294a1f1d12ba8436739"
    sha256 cellar: :any, arm64_sonoma:  "a07c29be19545f777dc15ac0f83c99b8f8b038476ae64a533fac974e0590fa5e"
    sha256 cellar: :any, sonoma:        "7a00f57eb1d67fa37e96a2b21d748ae477908dac04504b2cb19b95966426385f"
    sha256 cellar: :any, arm64_linux:   "d8b0ca66b30564fa9675555291f30bba2be17b64cc327b4e0df4fea70080254c"
    sha256 cellar: :any, x86_64_linux:  "c42baa2b689fd91baa62ad0a91ab20a2898f7a44b5e2cd97dbecfa18ceb2e2b3"
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
