# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.2.tgz"
  sha256 "d16b250a1efe85b7083125731a5f664ac6bc16114e09da5f63fac085769cc48d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ef43c66347c635ebcafff7382fff925328ea5732cee9b88d6e0f48b93f13de0d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6871f6a10fd749821af9151039237cfae47c731ffe7c8d9dffab1a01b8485dd8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c2bb3073f13efe85303aa790a24189fb017cc043e673873662202e8d83c4bbcf"
    sha256 cellar: :any_skip_relocation, sonoma:        "8ac45ad0a8f07ca3f02202395ae79e28046998974c18d5f4612f5cac3ff9cdc3"
    sha256 cellar: :any,                 arm64_linux:   "e24ec827d5face0061f254ba479fce45bc02e4952cf31f3dca21920b8f0ac820"
    sha256 cellar: :any,                 x86_64_linux:  "ac63f2a1cfa575e75e7b2efa2e2732989cbdcfde5c59e4e3022aafc5974ca62a"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
