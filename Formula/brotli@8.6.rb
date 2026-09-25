# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT86 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.0.tgz"
  sha256 "97a69edd4f71046b1bd285d914741a60478e69a1db785c2b42aed940ab1fa18f"
  revision 1
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "14eb82986d5544664d68410f55a65ebb13cc9966741c9a240d722b91e31d6630"
    sha256 cellar: :any, arm64_tahoe:       "bd5b3e7ee21cb320087fec04aab8fd31f4e1e00bff8769d687b45291b0a6e91e"
    sha256 cellar: :any, arm64_sequoia:     "3e3b826ad062140e4d45aca71f79c7a3f05b45596b554c51743e1ed66ecbb9f8"
    sha256 cellar: :any, arm64_linux:       "784c534419cadc5ff12830a56624b108ac8d727ead2e3220bf27d5ba309db941"
    sha256 cellar: :any, x86_64_linux:      "439a3f1322679f764c6c0f93f97e38b399955d0f0ef41fcc8f9c02a3e62420a7"
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
