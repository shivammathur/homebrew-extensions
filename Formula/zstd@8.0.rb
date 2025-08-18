# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "30fe5799fa0c41affd00d58df5f2d9cbb49fac4cdc5777b9590c03106f4d4a1f"
    sha256 cellar: :any,                 arm64_sonoma:  "195f302bbce780b3de1ab1365437bd305696821ab9b8a3dfed5114066de84511"
    sha256 cellar: :any,                 arm64_ventura: "cc9a06d7c8c211178a2ca94076d3bb080980071c6417eb2c398a433dfc3dc680"
    sha256 cellar: :any,                 ventura:       "bc35abcae5480d6c5fb268296e521bdbb167f1b07ad1e33625711a5f24a95a69"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "45cd18817cc4b73e8c99d4babd4f2eb7f838969d4d31ce41553653f8bcb296cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c9a99cd3f9c946711453baffe09aec211aa80a2398e0baa059945ead49548e93"
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
