# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.28.tar.xz"
  sha256 "0c8ec360e5dd8154f270b2fd50cd44ecc824e6ee39c85f911312b80d4daecd72"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.4(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8603127f33ccc5d969d275f310b03dc9a63780ede98deda21ba7e77279cf639d"
    sha256 cellar: :any, arm64_tahoe:       "a1b787ae2a08bd74abb400a70a8ca57e923914bd389da6272fd4e3b695e3b9a2"
    sha256 cellar: :any, arm64_sequoia:     "10e081b5b22f191f1795947a04ceb16fa814aad0cf8c38e2e745dd7838343a78"
    sha256 cellar: :any, arm64_linux:       "f8c401e02d76a5a63e54607bdf44d3df01a312d113b590b7f1d890eb33ee6958"
    sha256 cellar: :any, x86_64_linux:      "589fef28fcbc190a14c6e76f00dacaf2dc4b54d1be837e719bac26ba35befec6"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
