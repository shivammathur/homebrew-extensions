# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "0e32b81fedcb6c8bd398b0848507250f2416c8ecb82d5232e817dbd598d20253"
    sha256 cellar: :any,                 arm64_sonoma:  "abc6d29323055267dbec64eb364523fba0253afe103064938d141230e7dacf45"
    sha256 cellar: :any,                 arm64_ventura: "00f14e65d0ab48974282fbd275c2529a296a72a4f62f99ba4e95f9796d0a5d50"
    sha256 cellar: :any,                 ventura:       "db6744ede1a64bc2dccc79030889db4742251c1b99fb392f106d7079df34b48c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9cd89eb9d2e5f60ec403963520d92c409338736fd2c6932bc2b21b7e73aaba18"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7e88be8cb316ce3571b8aec40bc9964205e6af22d999c32fd5a31fe706471af"
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
