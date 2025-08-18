# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "2a9ab83242ff76359d24781852ff1ad5ae593344b1cc8f0831316784c16f1fd2"
    sha256 cellar: :any,                 arm64_sonoma:  "ae382cf73e59af3dc254b628f2b98115b5cdfe1ecfe04b7c78eaf78d5cd16d2e"
    sha256 cellar: :any,                 arm64_ventura: "1e47f95f8c60b97f9f84e425bb1822f318247aefe8c11e98a6c9a9890a7e1bc8"
    sha256 cellar: :any,                 ventura:       "262706d0e29d74f128e15acd71bbb4766c9248c4267641fc56b6e340cc068d09"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0dee67264fb534dd9eb4f754a6ad0e8615855f58c202c1d46f2bd2689dec5d96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2cb1745d4eeb6bd2bcd62b44d92c82fb19a509e1990bc4223141d848f8138ca2"
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
