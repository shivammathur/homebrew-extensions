# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.0.tgz"
  sha256 "927caeda88334a33934d17b7d3b70ff46e0649e577f1339dc711bdb853290345"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f43daa86c075d71e8f791b88475149e5bfe7e0a6a73aa7f491d7c9035d1d4818"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dca48429a887a1951a44feac44f0f16f8622bb42fafc92e8dcef294e3eef6a64"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c19771b21b0c7d7ecca792d4abff9703a283884c1f88b5c47fe4d74e1284af28"
    sha256 cellar: :any_skip_relocation, sonoma:        "7f12e6bc80abaf8e46a40d15cfbe90dcb827a8a10072df9a70653640cfe83ba5"
    sha256 cellar: :any,                 arm64_linux:   "068e595d51c2e6a217e0742360d5439f0162f962fd421784773da4f05f4ec65f"
    sha256 cellar: :any,                 x86_64_linux:  "49601d833a9e95bf9efa27972827878d7c88d6919111e3c7e6bf87d177e4c629"
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
