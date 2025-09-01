# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "86989650663b3e0753f031f5ad5eee69ae5688d0ee9f4016339d1f371f10a848"
    sha256 cellar: :any,                 arm64_sonoma:  "368ccf0f61bb7e34581f5235dba1d9e78c1fca90adb3dcbb6817e28dd0f31cbf"
    sha256 cellar: :any,                 arm64_ventura: "3394936a046e4f4babd8511285aa3a32c6aceca29bb9f7153fc138bbbe0aee36"
    sha256 cellar: :any,                 ventura:       "0b016dcb11cc1410940af889a890a5a78e8df41bd07127d2a538f2b47f976317"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "64021e2eefca0a9ad7260f079c1db415f6deb7fd2168590f66c1e136feb5ef75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f703b58b76ccbfeca3fffa98ed728366af313a31c1b8b2552a0868e2ab86fca3"
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
