# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT56 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.14.2.tgz"
  sha256 "db02e9106355f9a29f2ee75e31e4cc808fdcb69105ccdfbec4640f994a5f0a08"
  revision 1
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "dd7d47b4b40ecebddd175ab2710dbb7e65dffd9357d5bfd39f5bcae7157d550e"
    sha256 cellar: :any, arm64_tahoe:       "f4902e8da9e2f748b6cc1412ae894d222417f1934a04094e9a76071f22537435"
    sha256 cellar: :any, arm64_sequoia:     "aaa25dec5f75103e922b206d76e5f512d3ce3975436732cc7f73ff425dcc833b"
    sha256 cellar: :any, arm64_linux:       "9394667a504c096c43a7ab9901eea5a3b641f864844e81b4549eeb1dd52de651"
    sha256 cellar: :any, x86_64_linux:      "728a9f6edfa85d9893464581082a1cf0d12e5c44b52de69d13c5cb2fd2debbc2"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
