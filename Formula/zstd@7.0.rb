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
    sha256 cellar: :any,                 arm64_sequoia: "c39403adb6ec8120e5a7fd48070dbd5d198f5cafe6579f4aa3b728e2389478b7"
    sha256 cellar: :any,                 arm64_sonoma:  "eec1c7b2be89b60e4b6fdbaa0dbb7506f1e872c1e7282b44e958aa5475fe2623"
    sha256 cellar: :any,                 arm64_ventura: "cbfd86d318d3e69d8ed958fc7cc24f9ab195beb7d4397ec74d1dcfdeacb4a76d"
    sha256 cellar: :any,                 ventura:       "4e2f99e32e48d265cb86606e039b03ec12d8fcc4c976d6744032c4d524b745d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6ba9cef171e255a42275900d5280e40ae46d601ac598a0ee3b54b4b88a04117c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e52963739f4f5601d051c35e60653d37f65a7e73e554ecc65fb9516c41b1d03c"
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
