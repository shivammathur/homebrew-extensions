# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT73 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.1.tgz"
  sha256 "5dd4358a14fca60c41bd35bf9ec810b8ece07b67615dd1a756d976475bb04abe"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9e63c9bbda8164654cd0a04b33ee4832dddd6f8efc943de7889eec5432ea89e2"
    sha256 cellar: :any,                 arm64_sonoma:  "ea2e8e71ccd6f4cff39caaf8ad9eb8e7cd59a60d919e77dafe02401a29007296"
    sha256 cellar: :any,                 arm64_ventura: "0d3313441a25427dac9be1624dce08bcb65ba583bd83550463b5f4c50d1a951e"
    sha256 cellar: :any,                 ventura:       "7e5c1ecd56512ce29db84b5f1f6e78b8ebf0b570fbdcee8aa637fa13d55862b4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "46df13d4823ac88158da272a8c85ad962df06cf620d3a4a6750290d0bbe82bb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2710e5d2860c367f123896265ee48d870442fa97f3dd84d3c3fe2f289907c70d"
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
