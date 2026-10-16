# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.23.0.tgz"
  sha256 "34738f486ac6ade23b70c4b5b4d8292b5fda3b334ea119b6b35dbcfab24df50d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "e175d26ee64f72abc260019a8cba244a83a906148beef3633b5fe8bcf448c51a"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5ebee0521abb9171263c7bb2bffce12aceebf3e649e37ddee3ec7a7df92004b3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "aa499859e7a006b35827c90ca40da8a42af47dfffa9807cfe04f97268e277e58"
    sha256 cellar: :any,                 arm64_linux:       "b25a03ca3f2b7bb63b5b148e12e3f5559f7f0d021ccc36ae1053cd008991deba"
    sha256 cellar: :any,                 x86_64_linux:      "bb6ee994fda4138813e9de45cc79b0054710367f0a6ac82a1aa5e0f08e4fa06f"
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
