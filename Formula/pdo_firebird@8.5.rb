# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.10.tar.xz"
  sha256 "6a8bebaa4d5a979a38db29a9373e9851f60c6b11f72172c585947e78f3081957"
  head "https://github.com/php/php-src.git", branch: "PHP-8.5"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.5(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "eeb8cfa3b38a186943139d45990b31b5ff6ad0525c01a7140930ac40a4e558ef"
    sha256 cellar: :any, arm64_sequoia: "b7550aa01a81ab6a68978df53f8c9606843e6602b2bb73dba69942fc1429892a"
    sha256 cellar: :any, arm64_sonoma:  "5e5fe8f3e8bb498176aca75f32850cfb93a88b74682b82af3b2d17975aa10175"
    sha256 cellar: :any, sonoma:        "bd125b657cee8e75c79a0771b2ca8c27e27600a98149d6a256026c40b0a9e784"
    sha256 cellar: :any, arm64_linux:   "565289bfe221ee8fb8a0dd09f4e1be37529dfbb74f36725ca8feed683e19ab1e"
    sha256 cellar: :any, x86_64_linux:  "be0b0f6dbeb4c1309d8694774ab53d9abcc39fd95387eba774c2fb6530f3f57a"
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
