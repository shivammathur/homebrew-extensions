# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.1.tgz"
  sha256 "b280d9e9c146586648b0d4c14720220b9e1aaa1a3083a31ab1665784c90601d0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "c1a38d1368852f88342c4dbfc3b28f222b3778ba5f041bb13d2d8273c145cec6"
    sha256 cellar: :any, arm64_golden_gate: "48e47735414290dc8e93e17f9b4986f25c4c745c868497071b49bd9a4a22f9f3"
    sha256 cellar: :any, arm64_tahoe:       "beeda8805acd0c533ec6084b0a6f6d8c695b38038f4ced68167f3fe5692149ef"
    sha256 cellar: :any, arm64_sequoia:     "6fabb40a94e5fa08e3832c15c3a145e995d5a2c7a3be4e1c179b51d08331b1ee"
    sha256 cellar: :any, arm64_linux:       "28ac68f3fd103b12eacf6e45132916be735d618c3fc418bf9bd1ac204a6369a3"
    sha256 cellar: :any, x86_64_linux:      "5a18d4dfef040a3a414bb863077c312bfcce8643e79ac7903b289f7abbf3e908"
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
