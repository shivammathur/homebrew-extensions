# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.1.tgz"
  sha256 "b280d9e9c146586648b0d4c14720220b9e1aaa1a3083a31ab1665784c90601d0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "2e4f41543e663e4ab0a4f1e7dbe1a6b37594411686026ff07a8f12e24063d957"
    sha256 cellar: :any, arm64_golden_gate: "d4094aed69a42506df0a81dbd7f47e32f67bebce2159512d5ee6a65b4d467b71"
    sha256 cellar: :any, arm64_tahoe:       "8c96230d265d2fc472671c438f638c2c3e176c61e6bdd7ab40e80af74f558f68"
    sha256 cellar: :any, arm64_sequoia:     "ba193d844505668e154b9d61a45b10a6dc09578095802804f8969fe5948c5c35"
    sha256 cellar: :any, arm64_linux:       "402a2a46a332b1dde2e5a59d3a06dbe031d55edb5070442e9a174ff3ebfb8c6d"
    sha256 cellar: :any, x86_64_linux:      "34346b9c8cc5f830360f0a4609c185517913a60d83fce47e563fae09abc8f8ba"
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
