# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "921a00c3aa541596cbde00deef223ec698ac7360f043cbe793f750b5135e5c27"
    sha256 cellar: :any,                 arm64_sonoma:  "de87d4e49a2c6d116b03f340cf65f7d2f1eb62bc028100ed036bfa73e64fa9be"
    sha256 cellar: :any,                 arm64_ventura: "c8f257d0931bfcc81691f1020fb69915abe7de0a0cf966449a023286fd74cee2"
    sha256 cellar: :any,                 ventura:       "7f7184d95444b7f69970bdddb234a76823ebe14a1e5f97fb067e1b91e620861e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "95c8c02a7474683266b4a598ebe18d240cb431bc4cbb475770ab2b5d87b49eb1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3213211ce6f1db968fadaf24d8c7e538714b73719d745b1e1317b9eda8b35a81"
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
