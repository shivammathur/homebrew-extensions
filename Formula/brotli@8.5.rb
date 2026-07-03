# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT85 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.20.0.tgz"
  sha256 "e8d303afa3df0afc4e1362496482e3d20052b3bb478027b597073c8114d1f2ea"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "39c60c0f5e3c22537271375fc18f9c0c44f831dcd9e88d77ad2920e5b90a44d4"
    sha256 cellar: :any, arm64_sequoia: "d94f449c9547266d4cf13f8aa3177b2e62203223dc7ab1ef2e28a8be7dd98d19"
    sha256 cellar: :any, arm64_sonoma:  "838f55e0f1ac8b486657c531842bfcf1067a1c9f8793954f8f23b453fbbee6eb"
    sha256 cellar: :any, sonoma:        "ef2bec2f5f4bda10695bf8049ace104947d3b863bbeae5e518f6ba37464546f0"
    sha256 cellar: :any, arm64_linux:   "6dc5119d50886f7060ef4e797aa210e934e45956783de9b902573483a9a73f3a"
    sha256 cellar: :any, x86_64_linux:  "1aed2dd17b208ec5ff28dcc4dc402ab483df6f207dd32e484da8ca547e40432b"
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
