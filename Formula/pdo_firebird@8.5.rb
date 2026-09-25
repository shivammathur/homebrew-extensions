# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.11.tar.xz"
  sha256 "d9be75c08e8c316f4c8f4194d8fbe1750a15f6a6d9d4e3fe72082abeeb800360"
  head "https://github.com/php/php-src.git", branch: "PHP-8.5"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.5(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "188f6cd602304c69521604604f0d01fd3055caf178de6fb112b4d8f4ff2c5117"
    sha256 cellar: :any, arm64_tahoe:       "ae63d1cc95be4de0f366801496328e318643e3de0f565c32dd380c14e9c44227"
    sha256 cellar: :any, arm64_sequoia:     "47fa20da65c162839aff0a4c446126208b9a76710369658af60c7198bfabe455"
    sha256 cellar: :any, arm64_sonoma:      "19b5694447426020a5e811d959cd8add4f5955e029780e7cf33f9a2b8e7e2c31"
    sha256 cellar: :any, sonoma:            "f5eb54a9fd1226982fa6490d580e10f17cdd0dab2b0c3268314fd7706e619e11"
    sha256 cellar: :any, arm64_linux:       "fccb7e193921fa29f1e65e09d35b6a51c596c0a70a64921e424bce4c18814304"
    sha256 cellar: :any, x86_64_linux:      "bb056b26f3ba925743b86e74e1a324719c2c54dd3ebb146b226dd311bdac578c"
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
