# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "bfd5ae0104ca9837eb23236c6fd20e36605e40e8668b40896790c423ad10cdca"
    sha256 cellar: :any,                 arm64_sonoma:  "71330377bb0a4878be022e728509d4566901177b48fe3f2153360cb7162ba7eb"
    sha256 cellar: :any,                 arm64_ventura: "8c37d0beb1f0820b8b6519d972cb7c3d809eb603f16f49ecd827e90d81e30f9c"
    sha256 cellar: :any,                 ventura:       "afd618049ad5ce2ef908e51861dd138f02703de731fa33145a8ef095e0c3cd93"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "03f91711927493a0a8455a66d8e05d8c19e7ad68afa014d0fdcee128363e92e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9cb023cdf3db9f5e6657f47949656ff4285540e98fb9c1189edaaa132c6fceea"
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
