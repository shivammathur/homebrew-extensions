# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT87 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "2abc2119d6de12f70a1e7bcb1102707972ee419918bf4a337bfcbcab7bc06f1f"
    sha256 cellar: :any, arm64_tahoe:       "fb10c6d9f35f8bdd89de36b224f7e607dee4152bc6bceabca7273e2a68259a2b"
    sha256 cellar: :any, arm64_sequoia:     "6914bc0dbf0eed14f9386d9e839ee0c9210ea05112691f59edc111e57f54b606"
    sha256 cellar: :any, arm64_linux:       "4b9c864f7025691d0e28e4b95bc70cedcd38f5ddf777b9b852ec7670c8dcb4d4"
    sha256 cellar: :any, x86_64_linux:      "202d5f1793347bf04029041e97de80e7fc956e62da2efcb6d4aaaa989ffdbb98"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
