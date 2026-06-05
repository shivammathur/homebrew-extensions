# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT73 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.16.0.tgz"
  sha256 "3d5bfdd1c70b0e3e892461fca3bc74e899322c69404b706fec27af8118d9bf99"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "d6eba7caf53ae2ae24ab3945fce126fa15af8eff4901e322fde9e9dd4fd176d2"
    sha256 cellar: :any, arm64_sequoia: "f04d7a845d6f028b7b6d0160b9b43d417457cf0db0320661f03e19a75e9d54e9"
    sha256 cellar: :any, arm64_sonoma:  "31dddf63c7e2642f81ffe5b8fba863481f1d6b0d47e10aac3be2af23e6cd1ffa"
    sha256 cellar: :any, sonoma:        "a093b9d233b906eaa9f7cb0a3cb0d4ded50d1a6da2be034bb3b95e1c9c7a39d6"
    sha256 cellar: :any, arm64_linux:   "fb6983fb197373e9e40260dd116fc75565f6f8356fc9c710d083cf0f71651ad9"
    sha256 cellar: :any, x86_64_linux:  "37e5fadec64cd267561fe628f8ade5128b80d8703e8b9fd889799a2bfb482c8e"
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
