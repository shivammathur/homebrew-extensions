# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT71 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.0.tgz"
  sha256 "cd8bb6276f5bf44c4de759806c7c1c3ce5e1d51e2307e6a72bf8d26f84e89a51"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3f945fb701eaf74469557dc944feb3080cc836d6f58534450f2f6bf675d5f46e"
    sha256 cellar: :any,                 arm64_sonoma:  "d693db94de48a0fe616cc061afa120dc81311291cace24fc995a9cb8e0eee05a"
    sha256 cellar: :any,                 arm64_ventura: "f2c674c16c783c5600c7d42fa583703e5e41fc7285bcb64c2fc434a8a1ade709"
    sha256 cellar: :any,                 ventura:       "1834c240d5e3e02223f83b5278c56451582cdbf1cf5de65e712fd1a3a7664e05"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d41ab9e1d6afe9415f8b346d868babdc1a4bab6dec6e54af10951daf79d0c483"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "629c4082239875cee18f63bdede996beba433202005ce642bf0b5d6c64ee7bc1"
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
